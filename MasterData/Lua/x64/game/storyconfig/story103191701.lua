return {
	Play319171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319171001
		arg_1_1.duration_ = 3.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11p == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11p")
				var_4_0.name = "I11p"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11p = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11p

				arg_1_1.bgs_.I11p.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11p" then
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

			local var_4_8 = "4040ui_story"

			if arg_1_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["4040ui_story"].transform

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1.var_.moveOldPos4040ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_1_1.time_ - 1.9) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.9 + var_4_13 and arg_1_1.time_ < 1.9 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.55, -5.5)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["4040ui_story"]

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect4040ui_story == nil then
				arg_1_1.var_.characterEffect4040ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect4040ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.9 + var_4_15 and arg_1_1.time_ < 1.9 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect4040ui_story then
				arg_1_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.05

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(319171001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 2 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 2)

				if (2 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 2)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171001", "story_v_out_319171.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_319171", "319171001", "story_v_out_319171.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_319171", "319171001", "story_v_out_319171.awb")

						arg_1_1:RecordAudio("319171001", var_4_28)
						arg_1_1:RecordAudio("319171001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319171", "319171001", "story_v_out_319171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319171", "319171001", "story_v_out_319171.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319171002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319171002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319171003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["4040ui_story"]) and arg_8_1.var_.characterEffect4040ui_story == nil then
				arg_8_1.var_.characterEffect4040ui_story = arg_8_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["4040ui_story"]) then
				if arg_8_1.var_.characterEffect4040ui_story and not isNil(arg_8_1.actors_["4040ui_story"]) then
					arg_8_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_8_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["4040ui_story"]) and arg_8_1.var_.characterEffect4040ui_story then
				arg_8_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_8_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_11_1 = arg_8_1.actors_["4040ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos4040ui_story = var_11_1.localPosition
			end

			local var_11_2 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_2 then
				var_11_1.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_2)
				var_11_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_1.position).x, (manager.ui.mainCamera.transform.position - var_11_1.position).y, (manager.ui.mainCamera.transform.position - var_11_1.position).z)
				var_11_1.localEulerAngles.z = 0
				var_11_1.localEulerAngles.x = 0
				var_11_1.localEulerAngles = var_11_1.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_2 and arg_8_1.time_ < 0 + var_11_2 + arg_11_0 then
				var_11_1.localPosition = Vector3.New(0, 100, 0)
				var_11_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_1.position).x, (manager.ui.mainCamera.transform.position - var_11_1.position).y, (manager.ui.mainCamera.transform.position - var_11_1.position).z)
				var_11_1.localEulerAngles.z = 0
				var_11_1.localEulerAngles.x = 0
				var_11_1.localEulerAngles = var_11_1.localEulerAngles
			end

			local var_11_3 = 0
			local var_11_4 = 1.05

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

				local var_11_5 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(319171002).content)

				arg_8_1.text_.text = var_11_5

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_7 = 42 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 42)

				if (42 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 42)) > 0 and var_11_4 < var_11_7 then
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
				actorName = "4040ui_story",
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
	Play319171003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319171003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319171004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.325

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(319171003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 53 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 53)

				if (53 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 53)) > 0 and var_15_0 < var_15_3 then
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
	Play319171004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319171004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play319171005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.3

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(319171004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 52 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 52)

				if (52 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 52)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play319171005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319171005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319171006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_23_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_2 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_2

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_2
						arg_20_1.bgmTxt2_.text = var_23_2
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_20_1.time_ and arg_20_1.time_ <= 0.233333333333333 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_23_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_5 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_5

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_5
						arg_20_1.bgmTxt2_.text = var_23_5
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_23_6 = arg_20_1.actors_["4040ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos4040ui_story = var_23_6.localPosition
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_20_1.time_ - 0) / var_23_7)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, -1.55, -5.5)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			local var_23_8 = arg_20_1.actors_["4040ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.characterEffect4040ui_story == nil then
				arg_20_1.var_.characterEffect4040ui_story = var_23_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_9 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 and not isNil(var_23_8) then
				if arg_20_1.var_.characterEffect4040ui_story and not isNil(var_23_8) then
					arg_20_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.characterEffect4040ui_story then
				arg_20_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_23_11 = 0
			local var_23_12 = 0.05

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_13 = arg_20_1:GetWordFromCfg(319171005)
				local var_23_14 = arg_20_1:FormatText(var_23_13.content)

				arg_20_1.text_.text = var_23_14

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_16 = 2 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_14) / 2)

				if (2 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_14) / 2)) > 0 and var_23_12 < var_23_16 then
					arg_20_1.talkMaxDuration = var_23_16

					if var_23_16 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_11
					end
				end

				arg_20_1.text_.text = var_23_14
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171005", "story_v_out_319171.awb") ~= 0 then
					local var_23_17 = manager.audio:GetVoiceLength("story_v_out_319171", "319171005", "story_v_out_319171.awb") / 1000

					if var_23_17 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_11
					end

					if var_23_13.prefab_name ~= "" and arg_20_1.actors_[var_23_13.prefab_name] ~= nil then
						local var_23_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_13.prefab_name].transform, "story_v_out_319171", "319171005", "story_v_out_319171.awb")

						arg_20_1:RecordAudio("319171005", var_23_18)
						arg_20_1:RecordAudio("319171005", var_23_18)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_319171", "319171005", "story_v_out_319171.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_319171", "319171005", "story_v_out_319171.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_19 = math.max(var_23_12, arg_20_1.talkMaxDuration)

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_19 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_11) / var_23_19

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_11 + var_23_19 and arg_20_1.time_ < var_23_11 + var_23_19 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play319171006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 319171006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play319171007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["4040ui_story"]) and arg_26_1.var_.characterEffect4040ui_story == nil then
				arg_26_1.var_.characterEffect4040ui_story = arg_26_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["4040ui_story"]) then
				if arg_26_1.var_.characterEffect4040ui_story and not isNil(arg_26_1.actors_["4040ui_story"]) then
					arg_26_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_26_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_0)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["4040ui_story"]) and arg_26_1.var_.characterEffect4040ui_story then
				arg_26_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_26_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_29_1 = 0
			local var_29_2 = 0.9

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(319171006).content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 36 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 36)

				if (36 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 36)) > 0 and var_29_2 < var_29_5 then
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
	Play319171007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 319171007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play319171008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.525

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

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(319171007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 21 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 21)

				if (21 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 21)) > 0 and var_33_0 < var_33_3 then
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
	Play319171008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 319171008
		arg_34_1.duration_ = 2.93

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play319171009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos4040ui_story = arg_34_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_0)
				arg_34_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["4040ui_story"].transform.position).z)
				arg_34_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["4040ui_story"].transform.localEulerAngles = arg_34_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["4040ui_story"].transform.position).z)
				arg_34_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["4040ui_story"].transform.localEulerAngles = arg_34_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				local var_37_1 = arg_34_1.fswbg_.transform:Find("textbox/adapt/content") or arg_34_1.fswbg_.transform:Find("textbox/content")
				local var_37_2 = arg_34_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_37_3 = var_37_1:GetComponent("RectTransform")

				var_37_1:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_37_3.offsetMin = Vector2.New(0, 0)
				var_37_3.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.fswbg_:SetActive(true)
				arg_34_1.dialog_:SetActive(false)

				arg_34_1.fswtw_.percent = 0
				arg_34_1.fswt_.text = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(319171008).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.fswt_)

				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_34_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_34_1.fswtw_:SetDirty()

				arg_34_1.typewritterCharCountI18N = 0

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_4 = 0.666666666666667

			if 0.666666666666667 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_5 = 3
			local var_37_6 = 0.2
			local var_37_7, var_37_8 = arg_34_1:GetPercentByPara(arg_34_1:FormatText(arg_34_1:GetWordFromCfg(319171008).content), 1)

			if var_37_4 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				local var_37_9 = var_37_5 <= 0 and var_37_6 or var_37_6 * ((var_37_8 - arg_34_1.typewritterCharCountI18N) / var_37_5)

				if (var_37_5 <= 0 and var_37_6 or var_37_6 * ((var_37_8 - arg_34_1.typewritterCharCountI18N) / var_37_5)) > 0 and var_37_6 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_4
					end
				end
			end

			local var_37_10 = math.max(0.2, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_10 then
				arg_34_1.fswtw_.percent = Mathf.Lerp(arg_34_1.var_.oldValueTypewriter, var_37_7, (arg_34_1.time_ - var_37_4) / var_37_10)
				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.fswtw_:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_10 and arg_34_1.time_ < var_37_4 + var_37_10 + arg_37_0 then
				arg_34_1.fswtw_.percent = var_37_7

				arg_34_1.fswtw_:SetDirty()
				arg_34_1:ShowNextGo(true)

				arg_34_1.typewritterCharCountI18N = var_37_8
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.cswbg_:SetActive(true)

				local var_37_11 = arg_34_1.cswt_:GetComponent("RectTransform")

				arg_34_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_37_11.offsetMin = Vector2.New(410, 330)
				var_37_11.offsetMax = Vector2.New(-400, -175)
				arg_34_1.cswt_.text = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(419048).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.cswt_)

				arg_34_1.cswt_.fontSize = 180
				arg_34_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_34_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_37_12 = "STblack"

			if arg_34_1.bgs_.STblack == nil then
				local var_37_13 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_37_12)
				var_37_13.name = var_37_12
				var_37_13.transform.parent = arg_34_1.stage_.transform
				var_37_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_[var_37_12] = var_37_13
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				local var_37_14 = arg_34_1.bgs_.STblack

				arg_34_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_15 = var_37_14:GetComponent("SpriteRenderer")

				if var_37_15 and var_37_15.sprite then
					local var_37_16 = 2 * (var_37_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_14.transform.localScale = Vector3.New(var_37_16 / var_37_15.sprite.bounds.size.y < var_37_16 * manager.ui.mainCameraCom_.aspect / var_37_15.sprite.bounds.size.x and var_37_16 * manager.ui.mainCameraCom_.aspect / var_37_15.sprite.bounds.size.x or var_37_16 / var_37_15.sprite.bounds.size.y, var_37_16 / var_37_15.sprite.bounds.size.y < var_37_16 * manager.ui.mainCameraCom_.aspect / var_37_15.sprite.bounds.size.x and var_37_16 * manager.ui.mainCameraCom_.aspect / var_37_15.sprite.bounds.size.x or var_37_16 / var_37_15.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "STblack" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_17 = 0.666666666666667
			local var_37_18 = manager.audio:GetVoiceLength("story_v_out_319171", "319171008", "story_v_out_319171.awb") / 1000

			if var_37_18 > 0 and 1.166 < var_37_18 and var_37_18 + var_37_17 > arg_34_1.duration_ then
				arg_34_1.duration_ = var_37_18 + var_37_17
			end

			if var_37_17 < arg_34_1.time_ and arg_34_1.time_ <= var_37_17 + arg_37_0 then
				arg_34_1:AudioAction("play", "voice", "story_v_out_319171", "319171008", "story_v_out_319171.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play319171009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319171009
		arg_38_1.duration_ = 6.8

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319171010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.fswbg_:SetActive(true)
				arg_38_1.dialog_:SetActive(false)

				arg_38_1.fswtw_.percent = 0
				arg_38_1.fswt_.text = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(319171009).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.fswt_)

				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_38_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_38_1.fswtw_:SetDirty()

				arg_38_1.typewritterCharCountI18N = 0

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_0 = 0.466666666666667

			if 0.466666666666667 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_1 = 25
			local var_41_2 = 1.66666666666667
			local var_41_3, var_41_4 = arg_38_1:GetPercentByPara(arg_38_1:FormatText(arg_38_1:GetWordFromCfg(319171009).content), 1)

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				local var_41_5 = var_41_1 <= 0 and var_41_2 or var_41_2 * ((var_41_4 - arg_38_1.typewritterCharCountI18N) / var_41_1)

				if (var_41_1 <= 0 and var_41_2 or var_41_2 * ((var_41_4 - arg_38_1.typewritterCharCountI18N) / var_41_1)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_0
					end
				end
			end

			local var_41_6 = math.max(1.66666666666667, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_6 then
				arg_38_1.fswtw_.percent = Mathf.Lerp(arg_38_1.var_.oldValueTypewriter, var_41_3, (arg_38_1.time_ - var_41_0) / var_41_6)
				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_38_1.fswtw_:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_6 and arg_38_1.time_ < var_41_0 + var_41_6 + arg_41_0 then
				arg_38_1.fswtw_.percent = var_41_3

				arg_38_1.fswtw_:SetDirty()
				arg_38_1:ShowNextGo(true)

				arg_38_1.typewritterCharCountI18N = var_41_4
			end

			local var_41_7 = 0.466666666666667
			local var_41_8 = manager.audio:GetVoiceLength("story_v_out_319171", "319171009", "story_v_out_319171.awb") / 1000

			if var_41_8 > 0 and 6.333 < var_41_8 and var_41_8 + var_41_7 > arg_38_1.duration_ then
				arg_38_1.duration_ = var_41_8 + var_41_7
			end

			if var_41_7 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 then
				arg_38_1:AudioAction("play", "voice", "story_v_out_319171", "319171009", "story_v_out_319171.awb")
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319171010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 319171010
		arg_42_1.duration_ = 6.6

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play319171011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.fswbg_:SetActive(true)
				arg_42_1.dialog_:SetActive(false)

				arg_42_1.fswtw_.percent = 0
				arg_42_1.fswt_.text = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(319171010).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.fswt_)

				arg_42_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_42_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_42_1.fswtw_:SetDirty()

				arg_42_1.typewritterCharCountI18N = 0

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_0 = 0.466666666666667

			if 0.466666666666667 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_1 = 30
			local var_45_2 = 2
			local var_45_3, var_45_4 = arg_42_1:GetPercentByPara(arg_42_1:FormatText(arg_42_1:GetWordFromCfg(319171010).content), 1)

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				local var_45_5 = var_45_1 <= 0 and var_45_2 or var_45_2 * ((var_45_4 - arg_42_1.typewritterCharCountI18N) / var_45_1)

				if (var_45_1 <= 0 and var_45_2 or var_45_2 * ((var_45_4 - arg_42_1.typewritterCharCountI18N) / var_45_1)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_0
					end
				end
			end

			local var_45_6 = math.max(2, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_6 then
				arg_42_1.fswtw_.percent = Mathf.Lerp(arg_42_1.var_.oldValueTypewriter, var_45_3, (arg_42_1.time_ - var_45_0) / var_45_6)
				arg_42_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_42_1.fswtw_:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_6 and arg_42_1.time_ < var_45_0 + var_45_6 + arg_45_0 then
				arg_42_1.fswtw_.percent = var_45_3

				arg_42_1.fswtw_:SetDirty()
				arg_42_1:ShowNextGo(true)

				arg_42_1.typewritterCharCountI18N = var_45_4
			end

			local var_45_7 = 0.466666666666667
			local var_45_8 = manager.audio:GetVoiceLength("story_v_out_319171", "319171010", "story_v_out_319171.awb") / 1000

			if var_45_8 > 0 and 6.133 < var_45_8 and var_45_8 + var_45_7 > arg_42_1.duration_ then
				arg_42_1.duration_ = var_45_8 + var_45_7
			end

			if var_45_7 < arg_42_1.time_ and arg_42_1.time_ <= var_45_7 + arg_45_0 then
				arg_42_1:AudioAction("play", "voice", "story_v_out_319171", "319171010", "story_v_out_319171.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play319171011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 319171011
		arg_46_1.duration_ = 3.57

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play319171012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.fswbg_:SetActive(true)
				arg_46_1.dialog_:SetActive(false)

				arg_46_1.fswtw_.percent = 0
				arg_46_1.fswt_.text = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(319171011).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.fswt_)

				arg_46_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_46_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_46_1.fswtw_:SetDirty()

				arg_46_1.typewritterCharCountI18N = 0

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_0 = 0.466666666666667

			if 0.466666666666667 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_1 = 14
			local var_49_2 = 0.933333333333333
			local var_49_3, var_49_4 = arg_46_1:GetPercentByPara(arg_46_1:FormatText(arg_46_1:GetWordFromCfg(319171011).content), 1)

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				local var_49_5 = var_49_1 <= 0 and var_49_2 or var_49_2 * ((var_49_4 - arg_46_1.typewritterCharCountI18N) / var_49_1)

				if (var_49_1 <= 0 and var_49_2 or var_49_2 * ((var_49_4 - arg_46_1.typewritterCharCountI18N) / var_49_1)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_0
					end
				end
			end

			local var_49_6 = math.max(0.933333333333333, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_6 then
				arg_46_1.fswtw_.percent = Mathf.Lerp(arg_46_1.var_.oldValueTypewriter, var_49_3, (arg_46_1.time_ - var_49_0) / var_49_6)
				arg_46_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_46_1.fswtw_:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_6 and arg_46_1.time_ < var_49_0 + var_49_6 + arg_49_0 then
				arg_46_1.fswtw_.percent = var_49_3

				arg_46_1.fswtw_:SetDirty()
				arg_46_1:ShowNextGo(true)

				arg_46_1.typewritterCharCountI18N = var_49_4
			end

			local var_49_7 = 0.466666666666667
			local var_49_8 = manager.audio:GetVoiceLength("story_v_out_319171", "319171011", "story_v_out_319171.awb") / 1000

			if var_49_8 > 0 and 3.1 < var_49_8 and var_49_8 + var_49_7 > arg_46_1.duration_ then
				arg_46_1.duration_ = var_49_8 + var_49_7
			end

			if var_49_7 < arg_46_1.time_ and arg_46_1.time_ <= var_49_7 + arg_49_0 then
				arg_46_1:AudioAction("play", "voice", "story_v_out_319171", "319171011", "story_v_out_319171.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play319171012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 319171012
		arg_50_1.duration_ = 2.93

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play319171013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.fswbg_:SetActive(true)
				arg_50_1.dialog_:SetActive(false)

				arg_50_1.fswtw_.percent = 0
				arg_50_1.fswt_.text = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(319171012).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.fswt_)

				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_50_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_50_1.fswtw_:SetDirty()

				arg_50_1.typewritterCharCountI18N = 0

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_0 = 0.733333333333333

			if 0.733333333333333 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.var_.oldValueTypewriter = arg_50_1.fswtw_.percent

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_1 = 7
			local var_53_2 = 0.466666666666667
			local var_53_3, var_53_4 = arg_50_1:GetPercentByPara(arg_50_1:FormatText(arg_50_1:GetWordFromCfg(319171012).content), 1)

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				local var_53_5 = var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_4 - arg_50_1.typewritterCharCountI18N) / var_53_1)

				if (var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_4 - arg_50_1.typewritterCharCountI18N) / var_53_1)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_0
					end
				end
			end

			local var_53_6 = math.max(0.466666666666667, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_6 then
				arg_50_1.fswtw_.percent = Mathf.Lerp(arg_50_1.var_.oldValueTypewriter, var_53_3, (arg_50_1.time_ - var_53_0) / var_53_6)
				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.fswtw_:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_6 and arg_50_1.time_ < var_53_0 + var_53_6 + arg_53_0 then
				arg_50_1.fswtw_.percent = var_53_3

				arg_50_1.fswtw_:SetDirty()
				arg_50_1:ShowNextGo(true)

				arg_50_1.typewritterCharCountI18N = var_53_4
			end

			local var_53_7 = 0.733333333333333
			local var_53_8 = manager.audio:GetVoiceLength("story_v_out_319171", "319171012", "story_v_out_319171.awb") / 1000

			if var_53_8 > 0 and 1 < var_53_8 and var_53_8 + var_53_7 > arg_50_1.duration_ then
				arg_50_1.duration_ = var_53_8 + var_53_7
			end

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1:AudioAction("play", "voice", "story_v_out_319171", "319171012", "story_v_out_319171.awb")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.cswbg_:SetActive(true)

				local var_53_10 = arg_50_1.cswt_:GetComponent("RectTransform")

				arg_50_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_53_10.offsetMin = Vector2.New(410, 330)
				var_53_10.offsetMax = Vector2.New(-400, -180)
				arg_50_1.cswt_.text = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(419049).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.cswt_)

				arg_50_1.cswt_.fontSize = 175
				arg_50_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_50_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play319171013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 319171013
		arg_54_1.duration_ = 5.47

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play319171014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.fswbg_:SetActive(true)
				arg_54_1.dialog_:SetActive(false)

				arg_54_1.fswtw_.percent = 0
				arg_54_1.fswt_.text = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(319171013).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.fswt_)

				arg_54_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_54_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_54_1.fswtw_:SetDirty()

				arg_54_1.typewritterCharCountI18N = 0

				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_54_1:ShowNextGo(false)
			end

			local var_57_0 = 0.366666666666667

			if 0.366666666666667 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.var_.oldValueTypewriter = arg_54_1.fswtw_.percent

				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_54_1:ShowNextGo(false)
			end

			local var_57_1 = 25
			local var_57_2 = 1.66666666666667
			local var_57_3, var_57_4 = arg_54_1:GetPercentByPara(arg_54_1:FormatText(arg_54_1:GetWordFromCfg(319171013).content), 1)

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				local var_57_5 = var_57_1 <= 0 and var_57_2 or var_57_2 * ((var_57_4 - arg_54_1.typewritterCharCountI18N) / var_57_1)

				if (var_57_1 <= 0 and var_57_2 or var_57_2 * ((var_57_4 - arg_54_1.typewritterCharCountI18N) / var_57_1)) > 0 and var_57_2 < var_57_5 then
					arg_54_1.talkMaxDuration = var_57_5

					if var_57_5 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + var_57_0
					end
				end
			end

			local var_57_6 = math.max(1.66666666666667, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_6 then
				arg_54_1.fswtw_.percent = Mathf.Lerp(arg_54_1.var_.oldValueTypewriter, var_57_3, (arg_54_1.time_ - var_57_0) / var_57_6)
				arg_54_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_54_1.fswtw_:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_6 and arg_54_1.time_ < var_57_0 + var_57_6 + arg_57_0 then
				arg_54_1.fswtw_.percent = var_57_3

				arg_54_1.fswtw_:SetDirty()
				arg_54_1:ShowNextGo(true)

				arg_54_1.typewritterCharCountI18N = var_57_4
			end

			local var_57_7 = 0.366666666666667
			local var_57_8 = manager.audio:GetVoiceLength("story_v_out_319171", "319171013", "story_v_out_319171.awb") / 1000

			if var_57_8 > 0 and 5.1 < var_57_8 and var_57_8 + var_57_7 > arg_54_1.duration_ then
				arg_54_1.duration_ = var_57_8 + var_57_7
			end

			if var_57_7 < arg_54_1.time_ and arg_54_1.time_ <= var_57_7 + arg_57_0 then
				arg_54_1:AudioAction("play", "voice", "story_v_out_319171", "319171013", "story_v_out_319171.awb")
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play319171014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 319171014
		arg_58_1.duration_ = 4.33

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play319171015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.fswbg_:SetActive(true)
				arg_58_1.dialog_:SetActive(false)

				arg_58_1.fswtw_.percent = 0
				arg_58_1.fswt_.text = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(319171014).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.fswt_)

				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_58_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_58_1.fswtw_:SetDirty()

				arg_58_1.typewritterCharCountI18N = 0

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_0 = 0.433333333333333

			if 0.433333333333333 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.var_.oldValueTypewriter = arg_58_1.fswtw_.percent

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_1 = 13
			local var_61_2 = 0.866666666666667
			local var_61_3, var_61_4 = arg_58_1:GetPercentByPara(arg_58_1:FormatText(arg_58_1:GetWordFromCfg(319171014).content), 1)

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				local var_61_5 = var_61_1 <= 0 and var_61_2 or var_61_2 * ((var_61_4 - arg_58_1.typewritterCharCountI18N) / var_61_1)

				if (var_61_1 <= 0 and var_61_2 or var_61_2 * ((var_61_4 - arg_58_1.typewritterCharCountI18N) / var_61_1)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_0
					end
				end
			end

			local var_61_6 = math.max(0.866666666666667, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_6 then
				arg_58_1.fswtw_.percent = Mathf.Lerp(arg_58_1.var_.oldValueTypewriter, var_61_3, (arg_58_1.time_ - var_61_0) / var_61_6)
				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.fswtw_:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_6 and arg_58_1.time_ < var_61_0 + var_61_6 + arg_61_0 then
				arg_58_1.fswtw_.percent = var_61_3

				arg_58_1.fswtw_:SetDirty()
				arg_58_1:ShowNextGo(true)

				arg_58_1.typewritterCharCountI18N = var_61_4
			end

			local var_61_7 = 0.433333333333333
			local var_61_8 = manager.audio:GetVoiceLength("story_v_out_319171", "319171014", "story_v_out_319171.awb") / 1000

			if var_61_8 > 0 and 3.9 < var_61_8 and var_61_8 + var_61_7 > arg_58_1.duration_ then
				arg_58_1.duration_ = var_61_8 + var_61_7
			end

			if var_61_7 < arg_58_1.time_ and arg_58_1.time_ <= var_61_7 + arg_61_0 then
				arg_58_1:AudioAction("play", "voice", "story_v_out_319171", "319171014", "story_v_out_319171.awb")
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play319171015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 319171015
		arg_62_1.duration_ = 6.63

		local var_62_0 = {
			zh = 5.1,
			ja = 6.633
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play319171016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				local var_65_0 = arg_62_1.bgs_.I11p

				arg_62_1.bgs_.I11p.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_65_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_1 = var_65_0:GetComponent("SpriteRenderer")

				if var_65_1 and var_65_1.sprite then
					local var_65_2 = 2 * (var_65_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_65_0.transform.localScale = Vector3.New(var_65_2 / var_65_1.sprite.bounds.size.y < var_65_2 * manager.ui.mainCameraCom_.aspect / var_65_1.sprite.bounds.size.x and var_65_2 * manager.ui.mainCameraCom_.aspect / var_65_1.sprite.bounds.size.x or var_65_2 / var_65_1.sprite.bounds.size.y, var_65_2 / var_65_1.sprite.bounds.size.y < var_65_2 * manager.ui.mainCameraCom_.aspect / var_65_1.sprite.bounds.size.x and var_65_2 * manager.ui.mainCameraCom_.aspect / var_65_1.sprite.bounds.size.x or var_65_2 / var_65_1.sprite.bounds.size.y, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "I11p" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_3 = 0

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_3 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_4 = 2

			if var_65_3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_3 + var_65_4 then
				local var_65_5 = Color.New(0, 0, 0)

				var_65_5.a = Mathf.Lerp(1, 0, (arg_62_1.time_ - var_65_3) / var_65_4)
				arg_62_1.mask_.color = var_65_5
			end

			if arg_62_1.time_ >= var_65_3 + var_65_4 and arg_62_1.time_ < var_65_3 + var_65_4 + arg_65_0 then
				local var_65_6 = Color.New(0, 0, 0)

				arg_62_1.mask_.enabled = false
				var_65_6.a = 0
				arg_62_1.mask_.color = var_65_6
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.fswbg_:SetActive(false)
				arg_62_1.dialog_:SetActive(false)
				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_62_1:ShowNextGo(false)
			end

			if 0.1 < arg_62_1.time_ and arg_62_1.time_ <= 0.1 + arg_65_0 then
				arg_62_1.fswbg_:SetActive(false)
				arg_62_1.dialog_:SetActive(false)
				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.cswbg_:SetActive(false)
			end

			local var_65_7 = arg_62_1.actors_["4040ui_story"].transform

			if 1.9 < arg_62_1.time_ and arg_62_1.time_ <= 1.9 + arg_65_0 then
				arg_62_1.var_.moveOldPos4040ui_story = var_65_7.localPosition
			end

			local var_65_8 = 0.001

			if 1.9 <= arg_62_1.time_ and arg_62_1.time_ < 1.9 + var_65_8 then
				var_65_7.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_62_1.time_ - 1.9) / var_65_8)
				var_65_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_7.position).x, (manager.ui.mainCamera.transform.position - var_65_7.position).y, (manager.ui.mainCamera.transform.position - var_65_7.position).z)
				var_65_7.localEulerAngles.z = 0
				var_65_7.localEulerAngles.x = 0
				var_65_7.localEulerAngles = var_65_7.localEulerAngles
			end

			if arg_62_1.time_ >= 1.9 + var_65_8 and arg_62_1.time_ < 1.9 + var_65_8 + arg_65_0 then
				var_65_7.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_65_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_7.position).x, (manager.ui.mainCamera.transform.position - var_65_7.position).y, (manager.ui.mainCamera.transform.position - var_65_7.position).z)
				var_65_7.localEulerAngles.z = 0
				var_65_7.localEulerAngles.x = 0
				var_65_7.localEulerAngles = var_65_7.localEulerAngles
			end

			local var_65_9 = arg_62_1.actors_["4040ui_story"]

			if 1.9 < arg_62_1.time_ and arg_62_1.time_ <= 1.9 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect4040ui_story == nil then
				arg_62_1.var_.characterEffect4040ui_story = var_65_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_10 = 0.200000002980232

			if 1.9 <= arg_62_1.time_ and arg_62_1.time_ < 1.9 + var_65_10 and not isNil(var_65_9) then
				if arg_62_1.var_.characterEffect4040ui_story and not isNil(var_65_9) then
					arg_62_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 1.9 + var_65_10 and arg_62_1.time_ < 1.9 + var_65_10 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect4040ui_story then
				arg_62_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 1.9 < arg_62_1.time_ and arg_62_1.time_ <= 1.9 + arg_65_0 then
				arg_62_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 1.9 < arg_62_1.time_ and arg_62_1.time_ <= 1.9 + arg_65_0 then
				arg_62_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_12 = 2
			local var_65_13 = 0.3

			if 2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_12 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_14 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_14:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_62_1.dialogCg_.alpha = arg_66_0
				end))
				var_65_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_15 = arg_62_1:GetWordFromCfg(319171015)
				local var_65_16 = arg_62_1:FormatText(var_65_15.content)

				arg_62_1.text_.text = var_65_16

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_18 = 12 <= 0 and var_65_13 or var_65_13 * (utf8.len(var_65_16) / 12)

				if (12 <= 0 and var_65_13 or var_65_13 * (utf8.len(var_65_16) / 12)) > 0 and var_65_13 < var_65_18 then
					arg_62_1.talkMaxDuration = var_65_18
					var_65_12 = var_65_12 + 0.3

					if var_65_18 + var_65_12 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_12
					end
				end

				arg_62_1.text_.text = var_65_16
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171015", "story_v_out_319171.awb") ~= 0 then
					local var_65_19 = manager.audio:GetVoiceLength("story_v_out_319171", "319171015", "story_v_out_319171.awb") / 1000

					if var_65_19 + var_65_12 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_19 + var_65_12
					end

					if var_65_15.prefab_name ~= "" and arg_62_1.actors_[var_65_15.prefab_name] ~= nil then
						local var_65_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_15.prefab_name].transform, "story_v_out_319171", "319171015", "story_v_out_319171.awb")

						arg_62_1:RecordAudio("319171015", var_65_20)
						arg_62_1:RecordAudio("319171015", var_65_20)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_319171", "319171015", "story_v_out_319171.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_319171", "319171015", "story_v_out_319171.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_21 = var_65_12 + 0.3
			local var_65_22 = math.max(var_65_13, arg_62_1.talkMaxDuration)

			if var_65_12 + 0.3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_21 + var_65_22 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_21) / var_65_22

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_21 + var_65_22 and arg_62_1.time_ < var_65_21 + var_65_22 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play319171016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319171016
		arg_68_1.duration_ = 7.1

		local var_68_0 = {
			zh = 7.1,
			ja = 6.2
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
				arg_68_0:Play319171017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if arg_68_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_71_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_68_1.stage_.transform)

				var_71_0.name = "1084ui_story"
				var_71_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["1084ui_story"] = var_71_0

				local var_71_1 = var_71_0:GetComponentInChildren(typeof(CharacterEffect))

				var_71_1.enabled = true

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end

				arg_68_1:ShowWeapon(var_71_1.transform, false)

				arg_68_1.var_["1084ui_story" .. "Animator"] = var_71_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_68_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_68_1.var_["1084ui_story" .. "LipSync"] = var_71_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_71_3 = arg_68_1.actors_["1084ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 and not isNil(var_71_3) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_3) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_6 = arg_68_1.actors_["4040ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect4040ui_story == nil then
				arg_68_1.var_.characterEffect4040ui_story = var_71_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_7 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 and not isNil(var_71_6) then
				if arg_68_1.var_.characterEffect4040ui_story and not isNil(var_71_6) then
					arg_68_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_68_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_7)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect4040ui_story then
				arg_68_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_68_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_71_8 = arg_68_1.actors_["1084ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_8.localPosition
			end

			local var_71_9 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_9 then
				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_68_1.time_ - 0) / var_71_9)
				var_71_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_8.position).x, (manager.ui.mainCamera.transform.position - var_71_8.position).y, (manager.ui.mainCamera.transform.position - var_71_8.position).z)
				var_71_8.localEulerAngles.z = 0
				var_71_8.localEulerAngles.x = 0
				var_71_8.localEulerAngles = var_71_8.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_9 and arg_68_1.time_ < 0 + var_71_9 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(0.7, -0.97, -6)
				var_71_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_8.position).x, (manager.ui.mainCamera.transform.position - var_71_8.position).y, (manager.ui.mainCamera.transform.position - var_71_8.position).z)
				var_71_8.localEulerAngles.z = 0
				var_71_8.localEulerAngles.x = 0
				var_71_8.localEulerAngles = var_71_8.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_71_10 = 0
			local var_71_11 = 0.875

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
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

				local var_71_12 = arg_68_1:GetWordFromCfg(319171016)
				local var_71_13 = arg_68_1:FormatText(var_71_12.content)

				arg_68_1.text_.text = var_71_13

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 35 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 35)

				if (35 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 35)) > 0 and var_71_11 < var_71_15 then
					arg_68_1.talkMaxDuration = var_71_15

					if var_71_15 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_15 + var_71_10
					end
				end

				arg_68_1.text_.text = var_71_13
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171016", "story_v_out_319171.awb") ~= 0 then
					local var_71_16 = manager.audio:GetVoiceLength("story_v_out_319171", "319171016", "story_v_out_319171.awb") / 1000

					if var_71_16 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_16 + var_71_10
					end

					if var_71_12.prefab_name ~= "" and arg_68_1.actors_[var_71_12.prefab_name] ~= nil then
						local var_71_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_12.prefab_name].transform, "story_v_out_319171", "319171016", "story_v_out_319171.awb")

						arg_68_1:RecordAudio("319171016", var_71_17)
						arg_68_1:RecordAudio("319171016", var_71_17)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319171", "319171016", "story_v_out_319171.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319171", "319171016", "story_v_out_319171.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_18 = math.max(var_71_11, arg_68_1.talkMaxDuration)

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_18 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_10) / var_71_18

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_10 + var_71_18 and arg_68_1.time_ < var_71_10 + var_71_18 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play319171017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319171017
		arg_72_1.duration_ = 5.2

		local var_72_0 = {
			zh = 2.8,
			ja = 5.2
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
				arg_72_0:Play319171018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos4040ui_story = arg_72_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["4040ui_story"].transform.position).z)
				arg_72_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["4040ui_story"].transform.localEulerAngles = arg_72_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_72_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["4040ui_story"].transform.position).z)
				arg_72_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["4040ui_story"].transform.localEulerAngles = arg_72_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["4040ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect4040ui_story == nil then
				arg_72_1.var_.characterEffect4040ui_story = var_75_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 and not isNil(var_75_1) then
				if arg_72_1.var_.characterEffect4040ui_story and not isNil(var_75_1) then
					arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect4040ui_story then
				arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_75_4 = arg_72_1.actors_["1084ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_5 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 and not isNil(var_75_4) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_4) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_5)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_75_6 = 0
			local var_75_7 = 0.325

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(319171017)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 13 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 13)

				if (13 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 13)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171017", "story_v_out_319171.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171017", "story_v_out_319171.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_319171", "319171017", "story_v_out_319171.awb")

						arg_72_1:RecordAudio("319171017", var_75_13)
						arg_72_1:RecordAudio("319171017", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_319171", "319171017", "story_v_out_319171.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_319171", "319171017", "story_v_out_319171.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play319171018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319171018
		arg_76_1.duration_ = 12.47

		local var_76_0 = {
			zh = 9.133,
			ja = 12.466
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
				arg_76_0:Play319171019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = arg_76_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).z)
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles = arg_76_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_76_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).z)
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles = arg_76_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1084ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_79_4 = arg_76_1.actors_["4040ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect4040ui_story == nil then
				arg_76_1.var_.characterEffect4040ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_5 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 and not isNil(var_79_4) then
				if arg_76_1.var_.characterEffect4040ui_story and not isNil(var_79_4) then
					arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_76_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_5)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect4040ui_story then
				arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_76_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_79_6 = 0
			local var_79_7 = 1.1

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
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

				local var_79_8 = arg_76_1:GetWordFromCfg(319171018)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 44 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 44)

				if (44 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 44)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171018", "story_v_out_319171.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171018", "story_v_out_319171.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_319171", "319171018", "story_v_out_319171.awb")

						arg_76_1:RecordAudio("319171018", var_79_13)
						arg_76_1:RecordAudio("319171018", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319171", "319171018", "story_v_out_319171.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319171", "319171018", "story_v_out_319171.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play319171019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319171019
		arg_80_1.duration_ = 3.4

		local var_80_0 = {
			zh = 2.5,
			ja = 3.4
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
				arg_80_0:Play319171020(arg_80_1)
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

			local var_83_1 = arg_80_1.actors_["4040ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect4040ui_story == nil then
				arg_80_1.var_.characterEffect4040ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect4040ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect4040ui_story then
				arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_83_4 = 0
			local var_83_5 = 0.25

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(319171019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 10 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 10)

				if (10 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 10)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171019", "story_v_out_319171.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171019", "story_v_out_319171.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_319171", "319171019", "story_v_out_319171.awb")

						arg_80_1:RecordAudio("319171019", var_83_11)
						arg_80_1:RecordAudio("319171019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319171", "319171019", "story_v_out_319171.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319171", "319171019", "story_v_out_319171.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319171020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319171020
		arg_84_1.duration_ = 3.83

		local var_84_0 = {
			zh = 2.666,
			ja = 3.833
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
				arg_84_0:Play319171021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = arg_84_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).z)
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles = arg_84_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
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
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_4 = arg_84_1.actors_["4040ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect4040ui_story == nil then
				arg_84_1.var_.characterEffect4040ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_5 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_5 and not isNil(var_87_4) then
				if arg_84_1.var_.characterEffect4040ui_story and not isNil(var_87_4) then
					arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_84_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_5)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_5 and arg_84_1.time_ < 0 + var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect4040ui_story then
				arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_84_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_87_6 = 0
			local var_87_7 = 0.325

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
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

				local var_87_8 = arg_84_1:GetWordFromCfg(319171020)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 13 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 13)

				if (13 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 13)) > 0 and var_87_7 < var_87_11 then
					arg_84_1.talkMaxDuration = var_87_11

					if var_87_11 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171020", "story_v_out_319171.awb") ~= 0 then
					local var_87_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171020", "story_v_out_319171.awb") / 1000

					if var_87_12 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_6
					end

					if var_87_8.prefab_name ~= "" and arg_84_1.actors_[var_87_8.prefab_name] ~= nil then
						local var_87_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_8.prefab_name].transform, "story_v_out_319171", "319171020", "story_v_out_319171.awb")

						arg_84_1:RecordAudio("319171020", var_87_13)
						arg_84_1:RecordAudio("319171020", var_87_13)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_319171", "319171020", "story_v_out_319171.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_319171", "319171020", "story_v_out_319171.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
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
	Play319171021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319171021
		arg_88_1.duration_ = 2

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319171022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos4040ui_story = arg_88_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4040ui_story"].transform.position).z)
				arg_88_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["4040ui_story"].transform.localEulerAngles = arg_88_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_88_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4040ui_story"].transform.position).z)
				arg_88_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["4040ui_story"].transform.localEulerAngles = arg_88_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["4040ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect4040ui_story == nil then
				arg_88_1.var_.characterEffect4040ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect4040ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect4040ui_story then
				arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_91_4 = arg_88_1.actors_["1084ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_5 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_5 and not isNil(var_91_4) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_4) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_5)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_5 and arg_88_1.time_ < 0 + var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_91_6 = 0
			local var_91_7 = 0.05

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_8 = arg_88_1:GetWordFromCfg(319171021)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 2 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 2)

				if (2 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 2)) > 0 and var_91_7 < var_91_11 then
					arg_88_1.talkMaxDuration = var_91_11

					if var_91_11 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171021", "story_v_out_319171.awb") ~= 0 then
					local var_91_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171021", "story_v_out_319171.awb") / 1000

					if var_91_12 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_6
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_319171", "319171021", "story_v_out_319171.awb")

						arg_88_1:RecordAudio("319171021", var_91_13)
						arg_88_1:RecordAudio("319171021", var_91_13)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319171", "319171021", "story_v_out_319171.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319171", "319171021", "story_v_out_319171.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play319171022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319171022
		arg_92_1.duration_ = 3.58

		local var_92_0 = {
			zh = 3.241,
			ja = 3.575
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
				arg_92_0:Play319171023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos4040ui_story = arg_92_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["4040ui_story"].transform.position).z)
				arg_92_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["4040ui_story"].transform.localEulerAngles = arg_92_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_92_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["4040ui_story"].transform.position).z)
				arg_92_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["4040ui_story"].transform.localEulerAngles = arg_92_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_95_1 = arg_92_1.actors_["4040ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect4040ui_story == nil then
				arg_92_1.var_.characterEffect4040ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect4040ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect4040ui_story then
				arg_92_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_4 = 0.775
			local var_95_5 = 0.225

			if 0.775 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_6 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_6:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:GetWordFromCfg(319171022)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 9 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_8) / 9)

				if (9 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_8) / 9)) > 0 and var_95_5 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10
					var_95_4 = var_95_4 + 0.3

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171022", "story_v_out_319171.awb") ~= 0 then
					local var_95_11 = manager.audio:GetVoiceLength("story_v_out_319171", "319171022", "story_v_out_319171.awb") / 1000

					if var_95_11 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_4
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_out_319171", "319171022", "story_v_out_319171.awb")

						arg_92_1:RecordAudio("319171022", var_95_12)
						arg_92_1:RecordAudio("319171022", var_95_12)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319171", "319171022", "story_v_out_319171.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319171", "319171022", "story_v_out_319171.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_13 = var_95_4 + 0.3
			local var_95_14 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 + 0.3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_13 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_13) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_13 + var_95_14 and arg_92_1.time_ < var_95_13 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play319171023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319171023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319171024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["4040ui_story"]) and arg_98_1.var_.characterEffect4040ui_story == nil then
				arg_98_1.var_.characterEffect4040ui_story = arg_98_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["4040ui_story"]) then
				if arg_98_1.var_.characterEffect4040ui_story and not isNil(arg_98_1.actors_["4040ui_story"]) then
					arg_98_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_98_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["4040ui_story"]) and arg_98_1.var_.characterEffect4040ui_story then
				arg_98_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_98_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_101_1 = 0
			local var_101_2 = 1.325

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(319171023).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 53 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 53)

				if (53 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 53)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play319171024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319171024
		arg_102_1.duration_ = 4.4

		local var_102_0 = {
			zh = 4.4,
			ja = 2.633
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
				arg_102_0:Play319171025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = arg_102_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) then
				if arg_102_1.var_.characterEffect1084ui_story and not isNil(arg_102_1.actors_["1084ui_story"]) then
					arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) and arg_102_1.var_.characterEffect1084ui_story then
				arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_2 = 0
			local var_105_3 = 0.5

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(319171024)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 20 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 20)

				if (20 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 20)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171024", "story_v_out_319171.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_319171", "319171024", "story_v_out_319171.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_319171", "319171024", "story_v_out_319171.awb")

						arg_102_1:RecordAudio("319171024", var_105_9)
						arg_102_1:RecordAudio("319171024", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_319171", "319171024", "story_v_out_319171.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_319171", "319171024", "story_v_out_319171.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_10 and arg_102_1.time_ < var_105_2 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play319171025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 319171025
		arg_106_1.duration_ = 3.27

		local var_106_0 = {
			zh = 2.066,
			ja = 3.266
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play319171026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos4040ui_story = arg_106_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["4040ui_story"].transform.position).z)
				arg_106_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["4040ui_story"].transform.localEulerAngles = arg_106_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_106_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["4040ui_story"].transform.position).z)
				arg_106_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["4040ui_story"].transform.localEulerAngles = arg_106_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["4040ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect4040ui_story == nil then
				arg_106_1.var_.characterEffect4040ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect4040ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect4040ui_story then
				arg_106_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_109_4 = arg_106_1.actors_["1084ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_5 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_5 and not isNil(var_109_4) then
				if arg_106_1.var_.characterEffect1084ui_story and not isNil(var_109_4) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_5)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_5 and arg_106_1.time_ < 0 + var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_109_6 = 0
			local var_109_7 = 0.225

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(319171025)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 9 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 9)

				if (9 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 9)) > 0 and var_109_7 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171025", "story_v_out_319171.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171025", "story_v_out_319171.awb") / 1000

					if var_109_12 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_6
					end

					if var_109_8.prefab_name ~= "" and arg_106_1.actors_[var_109_8.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_8.prefab_name].transform, "story_v_out_319171", "319171025", "story_v_out_319171.awb")

						arg_106_1:RecordAudio("319171025", var_109_13)
						arg_106_1:RecordAudio("319171025", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_319171", "319171025", "story_v_out_319171.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_319171", "319171025", "story_v_out_319171.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play319171026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 319171026
		arg_110_1.duration_ = 10.3

		local var_110_0 = {
			zh = 10.3,
			ja = 4.8
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
				arg_110_0:Play319171027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1084ui_story = arg_110_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1084ui_story"].transform.position).z)
				arg_110_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1084ui_story"].transform.localEulerAngles = arg_110_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_110_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1084ui_story"].transform.position).z)
				arg_110_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1084ui_story"].transform.localEulerAngles = arg_110_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_113_1 = arg_110_1.actors_["1084ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1084ui_story == nil then
				arg_110_1.var_.characterEffect1084ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect1084ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1084ui_story then
				arg_110_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_113_4 = arg_110_1.actors_["4040ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect4040ui_story == nil then
				arg_110_1.var_.characterEffect4040ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_5 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_5 and not isNil(var_113_4) then
				if arg_110_1.var_.characterEffect4040ui_story and not isNil(var_113_4) then
					arg_110_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_110_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_5)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_5 and arg_110_1.time_ < 0 + var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect4040ui_story then
				arg_110_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_110_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_113_6 = 0
			local var_113_7 = 0.9

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_8 = arg_110_1:GetWordFromCfg(319171026)
				local var_113_9 = arg_110_1:FormatText(var_113_8.content)

				arg_110_1.text_.text = var_113_9

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 36 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 36)

				if (36 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 36)) > 0 and var_113_7 < var_113_11 then
					arg_110_1.talkMaxDuration = var_113_11

					if var_113_11 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_9
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171026", "story_v_out_319171.awb") ~= 0 then
					local var_113_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171026", "story_v_out_319171.awb") / 1000

					if var_113_12 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_6
					end

					if var_113_8.prefab_name ~= "" and arg_110_1.actors_[var_113_8.prefab_name] ~= nil then
						local var_113_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_8.prefab_name].transform, "story_v_out_319171", "319171026", "story_v_out_319171.awb")

						arg_110_1:RecordAudio("319171026", var_113_13)
						arg_110_1:RecordAudio("319171026", var_113_13)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_319171", "319171026", "story_v_out_319171.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_319171", "319171026", "story_v_out_319171.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play319171027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 319171027
		arg_114_1.duration_ = 7.6

		local var_114_0 = {
			zh = 4.3,
			ja = 7.6
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
				arg_114_0:Play319171028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.475

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(319171027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 19 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 19)

				if (19 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 19)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171027", "story_v_out_319171.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_319171", "319171027", "story_v_out_319171.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_319171", "319171027", "story_v_out_319171.awb")

						arg_114_1:RecordAudio("319171027", var_117_6)
						arg_114_1:RecordAudio("319171027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_319171", "319171027", "story_v_out_319171.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_319171", "319171027", "story_v_out_319171.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play319171028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 319171028
		arg_118_1.duration_ = 2.83

		local var_118_0 = {
			zh = 1.633,
			ja = 2.833
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
				arg_118_0:Play319171029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = arg_118_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(arg_118_1.actors_["1084ui_story"]) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_121_1 = arg_118_1.actors_["4040ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect4040ui_story == nil then
				arg_118_1.var_.characterEffect4040ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect4040ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect4040ui_story then
				arg_118_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_121_4 = 0
			local var_121_5 = 0.15

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(319171028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 6 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 6)

				if (6 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 6)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171028", "story_v_out_319171.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171028", "story_v_out_319171.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_319171", "319171028", "story_v_out_319171.awb")

						arg_118_1:RecordAudio("319171028", var_121_11)
						arg_118_1:RecordAudio("319171028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_319171", "319171028", "story_v_out_319171.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_319171", "319171028", "story_v_out_319171.awb")
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

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play319171029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 319171029
		arg_122_1.duration_ = 10.13

		local var_122_0 = {
			zh = 6.7,
			ja = 10.133
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play319171030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.775

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:GetWordFromCfg(319171029)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 31 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 31)

				if (31 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 31)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171029", "story_v_out_319171.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_319171", "319171029", "story_v_out_319171.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_319171", "319171029", "story_v_out_319171.awb")

						arg_122_1:RecordAudio("319171029", var_125_6)
						arg_122_1:RecordAudio("319171029", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_319171", "319171029", "story_v_out_319171.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_319171", "319171029", "story_v_out_319171.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play319171030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 319171030
		arg_126_1.duration_ = 5.07

		local var_126_0 = {
			zh = 4.666,
			ja = 5.066
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
				arg_126_0:Play319171031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1084ui_story"]) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = arg_126_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1084ui_story"]) then
				if arg_126_1.var_.characterEffect1084ui_story and not isNil(arg_126_1.actors_["1084ui_story"]) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1084ui_story"]) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_129_2 = arg_126_1.actors_["4040ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect4040ui_story == nil then
				arg_126_1.var_.characterEffect4040ui_story = var_129_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_3 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.characterEffect4040ui_story and not isNil(var_129_2) then
					arg_126_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_126_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_3)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect4040ui_story then
				arg_126_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_126_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_4 = 0
			local var_129_5 = 0.6

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(319171030)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 24 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 24)

				if (24 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 24)) > 0 and var_129_5 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171030", "story_v_out_319171.awb") ~= 0 then
					local var_129_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171030", "story_v_out_319171.awb") / 1000

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end

					if var_129_6.prefab_name ~= "" and arg_126_1.actors_[var_129_6.prefab_name] ~= nil then
						local var_129_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_6.prefab_name].transform, "story_v_out_319171", "319171030", "story_v_out_319171.awb")

						arg_126_1:RecordAudio("319171030", var_129_11)
						arg_126_1:RecordAudio("319171030", var_129_11)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_319171", "319171030", "story_v_out_319171.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_319171", "319171030", "story_v_out_319171.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_12 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_12 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_12

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_12 and arg_126_1.time_ < var_129_4 + var_129_12 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play319171031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 319171031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play319171032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1084ui_story"]) and arg_130_1.var_.characterEffect1084ui_story == nil then
				arg_130_1.var_.characterEffect1084ui_story = arg_130_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1084ui_story"]) then
				if arg_130_1.var_.characterEffect1084ui_story and not isNil(arg_130_1.actors_["1084ui_story"]) then
					arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_0)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1084ui_story"]) and arg_130_1.var_.characterEffect1084ui_story then
				arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_133_1 = 0
			local var_133_2 = 1.125

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_3 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(319171031).content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 45 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 45)

				if (45 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 45)) > 0 and var_133_2 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_6 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_6 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_6

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_6 and arg_130_1.time_ < var_133_1 + var_133_6 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play319171032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319171032
		arg_134_1.duration_ = 2.67

		local var_134_0 = {
			zh = 1.6,
			ja = 2.666
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
				arg_134_0:Play319171033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos4040ui_story = arg_134_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["4040ui_story"].transform.position).z)
				arg_134_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["4040ui_story"].transform.localEulerAngles = arg_134_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_134_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["4040ui_story"].transform.position).z)
				arg_134_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["4040ui_story"].transform.localEulerAngles = arg_134_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["4040ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect4040ui_story == nil then
				arg_134_1.var_.characterEffect4040ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect4040ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect4040ui_story then
				arg_134_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_137_4 = 0
			local var_137_5 = 0.15

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(319171032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 6 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 6)

				if (6 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 6)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171032", "story_v_out_319171.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171032", "story_v_out_319171.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_319171", "319171032", "story_v_out_319171.awb")

						arg_134_1:RecordAudio("319171032", var_137_11)
						arg_134_1:RecordAudio("319171032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_319171", "319171032", "story_v_out_319171.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_319171", "319171032", "story_v_out_319171.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
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

		arg_134_1:InitPlayNodeList()
	end,
	Play319171033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 319171033
		arg_138_1.duration_ = 5.07

		local var_138_0 = {
			zh = 4.8,
			ja = 5.066
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
				arg_138_0:Play319171034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1084ui_story = arg_138_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).z)
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles = arg_138_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_138_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).z)
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles = arg_138_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1084ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1084ui_story then
				arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_4 = arg_138_1.actors_["4040ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect4040ui_story == nil then
				arg_138_1.var_.characterEffect4040ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_5 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 and not isNil(var_141_4) then
				if arg_138_1.var_.characterEffect4040ui_story and not isNil(var_141_4) then
					arg_138_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_138_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_5)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect4040ui_story then
				arg_138_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_138_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_141_6 = 0
			local var_141_7 = 0.6

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(319171033)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 24 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 24)

				if (24 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 24)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171033", "story_v_out_319171.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171033", "story_v_out_319171.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_319171", "319171033", "story_v_out_319171.awb")

						arg_138_1:RecordAudio("319171033", var_141_13)
						arg_138_1:RecordAudio("319171033", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_319171", "319171033", "story_v_out_319171.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_319171", "319171033", "story_v_out_319171.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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

		arg_138_1:InitPlayNodeList()
	end,
	Play319171034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 319171034
		arg_142_1.duration_ = 6.7

		local var_142_0 = {
			zh = 4.666,
			ja = 6.7
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play319171035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1084ui_story"]) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = arg_142_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1084ui_story"]) then
				if arg_142_1.var_.characterEffect1084ui_story and not isNil(arg_142_1.actors_["1084ui_story"]) then
					arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1084ui_story"]) and arg_142_1.var_.characterEffect1084ui_story then
				arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_145_1 = arg_142_1.actors_["4040ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_1) and arg_142_1.var_.characterEffect4040ui_story == nil then
				arg_142_1.var_.characterEffect4040ui_story = var_145_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_2 and not isNil(var_145_1) then
				if arg_142_1.var_.characterEffect4040ui_story and not isNil(var_145_1) then
					arg_142_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_2 and arg_142_1.time_ < 0 + var_145_2 + arg_145_0 and not isNil(var_145_1) and arg_142_1.var_.characterEffect4040ui_story then
				arg_142_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_145_4 = 0
			local var_145_5 = 0.525

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(319171034)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 21 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 21)

				if (21 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 21)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171034", "story_v_out_319171.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171034", "story_v_out_319171.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_319171", "319171034", "story_v_out_319171.awb")

						arg_142_1:RecordAudio("319171034", var_145_11)
						arg_142_1:RecordAudio("319171034", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_319171", "319171034", "story_v_out_319171.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_319171", "319171034", "story_v_out_319171.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play319171035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319171035
		arg_146_1.duration_ = 4.53

		local var_146_0 = {
			zh = 4.533,
			ja = 4.5
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play319171036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = arg_146_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) then
				if arg_146_1.var_.characterEffect1084ui_story and not isNil(arg_146_1.actors_["1084ui_story"]) then
					arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) and arg_146_1.var_.characterEffect1084ui_story then
				arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_149_2 = arg_146_1.actors_["4040ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect4040ui_story == nil then
				arg_146_1.var_.characterEffect4040ui_story = var_149_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_3 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.characterEffect4040ui_story and not isNil(var_149_2) then
					arg_146_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_146_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_3)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect4040ui_story then
				arg_146_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_146_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_149_4 = 0
			local var_149_5 = 0.525

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(319171035)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 21 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 21)

				if (21 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 21)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171035", "story_v_out_319171.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171035", "story_v_out_319171.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_out_319171", "319171035", "story_v_out_319171.awb")

						arg_146_1:RecordAudio("319171035", var_149_11)
						arg_146_1:RecordAudio("319171035", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_319171", "319171035", "story_v_out_319171.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_319171", "319171035", "story_v_out_319171.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play319171036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319171036
		arg_150_1.duration_ = 7.03

		local var_150_0 = {
			zh = 7.033,
			ja = 2.766
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319171037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1084ui_story"]) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = arg_150_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1084ui_story"]) then
				if arg_150_1.var_.characterEffect1084ui_story and not isNil(arg_150_1.actors_["1084ui_story"]) then
					arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_0)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1084ui_story"]) and arg_150_1.var_.characterEffect1084ui_story then
				arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_153_1 = arg_150_1.actors_["4040ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect4040ui_story == nil then
				arg_150_1.var_.characterEffect4040ui_story = var_153_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 and not isNil(var_153_1) then
				if arg_150_1.var_.characterEffect4040ui_story and not isNil(var_153_1) then
					arg_150_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect4040ui_story then
				arg_150_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_153_4 = 0
			local var_153_5 = 0.7

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_6 = arg_150_1:GetWordFromCfg(319171036)
				local var_153_7 = arg_150_1:FormatText(var_153_6.content)

				arg_150_1.text_.text = var_153_7

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 28 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 28)

				if (28 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 28)) > 0 and var_153_5 < var_153_9 then
					arg_150_1.talkMaxDuration = var_153_9

					if var_153_9 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_4
					end
				end

				arg_150_1.text_.text = var_153_7
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171036", "story_v_out_319171.awb") ~= 0 then
					local var_153_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171036", "story_v_out_319171.awb") / 1000

					if var_153_10 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_4
					end

					if var_153_6.prefab_name ~= "" and arg_150_1.actors_[var_153_6.prefab_name] ~= nil then
						local var_153_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_6.prefab_name].transform, "story_v_out_319171", "319171036", "story_v_out_319171.awb")

						arg_150_1:RecordAudio("319171036", var_153_11)
						arg_150_1:RecordAudio("319171036", var_153_11)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_319171", "319171036", "story_v_out_319171.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_319171", "319171036", "story_v_out_319171.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_12 = math.max(var_153_5, arg_150_1.talkMaxDuration)

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_4) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_4 + var_153_12 and arg_150_1.time_ < var_153_4 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319171037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 319171037
		arg_154_1.duration_ = 7.77

		local var_154_0 = {
			zh = 6.866,
			ja = 7.766
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play319171038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.7

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:GetWordFromCfg(319171037)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 28 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 28)

				if (28 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 28)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171037", "story_v_out_319171.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_319171", "319171037", "story_v_out_319171.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_319171", "319171037", "story_v_out_319171.awb")

						arg_154_1:RecordAudio("319171037", var_157_6)
						arg_154_1:RecordAudio("319171037", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_319171", "319171037", "story_v_out_319171.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_319171", "319171037", "story_v_out_319171.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play319171038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 319171038
		arg_158_1.duration_ = 5.1

		local var_158_0 = {
			zh = 1.533,
			ja = 5.1
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play319171039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1084ui_story"]) and arg_158_1.var_.characterEffect1084ui_story == nil then
				arg_158_1.var_.characterEffect1084ui_story = arg_158_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1084ui_story"]) then
				if arg_158_1.var_.characterEffect1084ui_story and not isNil(arg_158_1.actors_["1084ui_story"]) then
					arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1084ui_story"]) and arg_158_1.var_.characterEffect1084ui_story then
				arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_161_2 = arg_158_1.actors_["4040ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect4040ui_story == nil then
				arg_158_1.var_.characterEffect4040ui_story = var_161_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_3 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 and not isNil(var_161_2) then
				if arg_158_1.var_.characterEffect4040ui_story and not isNil(var_161_2) then
					arg_158_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_158_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_3)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect4040ui_story then
				arg_158_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_158_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_161_4 = 0
			local var_161_5 = 0.15

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(319171038)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 6 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 6)

				if (6 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 6)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171038", "story_v_out_319171.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171038", "story_v_out_319171.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_out_319171", "319171038", "story_v_out_319171.awb")

						arg_158_1:RecordAudio("319171038", var_161_11)
						arg_158_1:RecordAudio("319171038", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_319171", "319171038", "story_v_out_319171.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_319171", "319171038", "story_v_out_319171.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play319171039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 319171039
		arg_162_1.duration_ = 3.43

		local var_162_0 = {
			zh = 3.433,
			ja = 2.8
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play319171040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1084ui_story"]) and arg_162_1.var_.characterEffect1084ui_story == nil then
				arg_162_1.var_.characterEffect1084ui_story = arg_162_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1084ui_story"]) then
				if arg_162_1.var_.characterEffect1084ui_story and not isNil(arg_162_1.actors_["1084ui_story"]) then
					arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1084ui_story"]) and arg_162_1.var_.characterEffect1084ui_story then
				arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_165_1 = arg_162_1.actors_["4040ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect4040ui_story == nil then
				arg_162_1.var_.characterEffect4040ui_story = var_165_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 and not isNil(var_165_1) then
				if arg_162_1.var_.characterEffect4040ui_story and not isNil(var_165_1) then
					arg_162_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect4040ui_story then
				arg_162_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_165_4 = 0
			local var_165_5 = 0.325

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(319171039)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 13 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 13)

				if (13 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 13)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171039", "story_v_out_319171.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_out_319171", "319171039", "story_v_out_319171.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_out_319171", "319171039", "story_v_out_319171.awb")

						arg_162_1:RecordAudio("319171039", var_165_11)
						arg_162_1:RecordAudio("319171039", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_319171", "319171039", "story_v_out_319171.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_319171", "319171039", "story_v_out_319171.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play319171040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 319171040
		arg_166_1.duration_ = 6.3

		local var_166_0 = {
			zh = 6.3,
			ja = 4.133
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play319171041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1084ui_story = arg_166_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).z)
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles = arg_166_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_166_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).z)
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles = arg_166_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["1084ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect1084ui_story == nil then
				arg_166_1.var_.characterEffect1084ui_story = var_169_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 and not isNil(var_169_1) then
				if arg_166_1.var_.characterEffect1084ui_story and not isNil(var_169_1) then
					arg_166_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect1084ui_story then
				arg_166_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_169_4 = arg_166_1.actors_["4040ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect4040ui_story == nil then
				arg_166_1.var_.characterEffect4040ui_story = var_169_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_5 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_5 and not isNil(var_169_4) then
				if arg_166_1.var_.characterEffect4040ui_story and not isNil(var_169_4) then
					arg_166_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_166_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_5)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_5 and arg_166_1.time_ < 0 + var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect4040ui_story then
				arg_166_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_166_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_169_6 = 0
			local var_169_7 = 0.875

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_8 = arg_166_1:GetWordFromCfg(319171040)
				local var_169_9 = arg_166_1:FormatText(var_169_8.content)

				arg_166_1.text_.text = var_169_9

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 35 <= 0 and var_169_7 or var_169_7 * (utf8.len(var_169_9) / 35)

				if (35 <= 0 and var_169_7 or var_169_7 * (utf8.len(var_169_9) / 35)) > 0 and var_169_7 < var_169_11 then
					arg_166_1.talkMaxDuration = var_169_11

					if var_169_11 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_11 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_9
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171040", "story_v_out_319171.awb") ~= 0 then
					local var_169_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171040", "story_v_out_319171.awb") / 1000

					if var_169_12 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_12 + var_169_6
					end

					if var_169_8.prefab_name ~= "" and arg_166_1.actors_[var_169_8.prefab_name] ~= nil then
						local var_169_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_8.prefab_name].transform, "story_v_out_319171", "319171040", "story_v_out_319171.awb")

						arg_166_1:RecordAudio("319171040", var_169_13)
						arg_166_1:RecordAudio("319171040", var_169_13)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_319171", "319171040", "story_v_out_319171.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_319171", "319171040", "story_v_out_319171.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_14 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_14 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_14

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_14 and arg_166_1.time_ < var_169_6 + var_169_14 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play319171041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319171041
		arg_170_1.duration_ = 11.3

		local var_170_0 = {
			zh = 9.666,
			ja = 11.3
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
				arg_170_0:Play319171042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos4040ui_story = arg_170_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["4040ui_story"].transform.position).z)
				arg_170_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["4040ui_story"].transform.localEulerAngles = arg_170_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_170_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["4040ui_story"].transform.position).z)
				arg_170_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["4040ui_story"].transform.localEulerAngles = arg_170_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["4040ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect4040ui_story == nil then
				arg_170_1.var_.characterEffect4040ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect4040ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect4040ui_story then
				arg_170_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_173_4 = arg_170_1.actors_["1084ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.characterEffect1084ui_story == nil then
				arg_170_1.var_.characterEffect1084ui_story = var_173_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_5 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_5 and not isNil(var_173_4) then
				if arg_170_1.var_.characterEffect1084ui_story and not isNil(var_173_4) then
					arg_170_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_5)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_5 and arg_170_1.time_ < 0 + var_173_5 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.characterEffect1084ui_story then
				arg_170_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_173_6 = 0
			local var_173_7 = 1.025

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_8 = arg_170_1:GetWordFromCfg(319171041)
				local var_173_9 = arg_170_1:FormatText(var_173_8.content)

				arg_170_1.text_.text = var_173_9

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 41 <= 0 and var_173_7 or var_173_7 * (utf8.len(var_173_9) / 41)

				if (41 <= 0 and var_173_7 or var_173_7 * (utf8.len(var_173_9) / 41)) > 0 and var_173_7 < var_173_11 then
					arg_170_1.talkMaxDuration = var_173_11

					if var_173_11 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_6
					end
				end

				arg_170_1.text_.text = var_173_9
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171041", "story_v_out_319171.awb") ~= 0 then
					local var_173_12 = manager.audio:GetVoiceLength("story_v_out_319171", "319171041", "story_v_out_319171.awb") / 1000

					if var_173_12 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_6
					end

					if var_173_8.prefab_name ~= "" and arg_170_1.actors_[var_173_8.prefab_name] ~= nil then
						local var_173_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_8.prefab_name].transform, "story_v_out_319171", "319171041", "story_v_out_319171.awb")

						arg_170_1:RecordAudio("319171041", var_173_13)
						arg_170_1:RecordAudio("319171041", var_173_13)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_319171", "319171041", "story_v_out_319171.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_319171", "319171041", "story_v_out_319171.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_14 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_14 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_6) / var_173_14

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_6 + var_173_14 and arg_170_1.time_ < var_173_6 + var_173_14 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play319171042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 319171042
		arg_174_1.duration_ = 9.13

		local var_174_0 = {
			zh = 9.133,
			ja = 7.433
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play319171043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.075

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:GetWordFromCfg(319171042)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 43 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 43)

				if (43 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 43)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171042", "story_v_out_319171.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_319171", "319171042", "story_v_out_319171.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_319171", "319171042", "story_v_out_319171.awb")

						arg_174_1:RecordAudio("319171042", var_177_6)
						arg_174_1:RecordAudio("319171042", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_319171", "319171042", "story_v_out_319171.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_319171", "319171042", "story_v_out_319171.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play319171043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319171043
		arg_178_1.duration_ = 13.9

		local var_178_0 = {
			zh = 8.933,
			ja = 13.9
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
				arg_178_0:Play319171044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action434")
			end

			local var_181_0 = 0
			local var_181_1 = 0.825

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_2 = arg_178_1:GetWordFromCfg(319171043)
				local var_181_3 = arg_178_1:FormatText(var_181_2.content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 33 <= 0 and var_181_1 or var_181_1 * (utf8.len(var_181_3) / 33)

				if (33 <= 0 and var_181_1 or var_181_1 * (utf8.len(var_181_3) / 33)) > 0 and var_181_1 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319171", "319171043", "story_v_out_319171.awb") ~= 0 then
					local var_181_6 = manager.audio:GetVoiceLength("story_v_out_319171", "319171043", "story_v_out_319171.awb") / 1000

					if var_181_6 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_0
					end

					if var_181_2.prefab_name ~= "" and arg_178_1.actors_[var_181_2.prefab_name] ~= nil then
						local var_181_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_2.prefab_name].transform, "story_v_out_319171", "319171043", "story_v_out_319171.awb")

						arg_178_1:RecordAudio("319171043", var_181_7)
						arg_178_1:RecordAudio("319171043", var_181_7)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319171", "319171043", "story_v_out_319171.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319171", "319171043", "story_v_out_319171.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play319171044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319171044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play319171045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["4040ui_story"]) and arg_182_1.var_.characterEffect4040ui_story == nil then
				arg_182_1.var_.characterEffect4040ui_story = arg_182_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["4040ui_story"]) then
				if arg_182_1.var_.characterEffect4040ui_story and not isNil(arg_182_1.actors_["4040ui_story"]) then
					arg_182_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_182_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["4040ui_story"]) and arg_182_1.var_.characterEffect4040ui_story then
				arg_182_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_182_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_185_1 = 0
			local var_185_2 = 0.925

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(319171044).content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 37 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 37)

				if (37 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 37)) > 0 and var_185_2 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_6 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_6 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_6

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_6 and arg_182_1.time_ < var_185_1 + var_185_6 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play319171045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319171045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
			arg_186_1.auto_ = false
		end

		function arg_186_1.playNext_(arg_188_0)
			arg_186_1.onStoryFinished_()
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sword04", "")
			end

			local var_189_1 = arg_186_1.actors_["1084ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1084ui_story = var_189_1.localPosition
			end

			local var_189_2 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 then
				var_189_1.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_2)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 then
				var_189_1.localPosition = Vector3.New(0, 100, 0)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			local var_189_3 = arg_186_1.actors_["4040ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos4040ui_story = var_189_3.localPosition
			end

			local var_189_4 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				var_189_3.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_4)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				var_189_3.localPosition = Vector3.New(0, 100, 0)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			local var_189_5 = 0
			local var_189_6 = 1.6

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_7 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(319171045).content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 64 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_7) / 64)

				if (64 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_7) / 64)) > 0 and var_189_6 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_10 and arg_186_1.time_ < var_189_5 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_186_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11p",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319171.awb"
	}
}
