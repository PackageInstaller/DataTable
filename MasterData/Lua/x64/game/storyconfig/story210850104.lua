return {
	Play1108504001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108504001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108504002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 2.3 < arg_1_1.time_ and arg_1_1.time_ <= 2.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.825

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1108504001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 33 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 33)

				if (33 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 33)) > 0 and var_4_15 < var_4_19 then
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
	Play1108504002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108504002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1108504003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.5

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1108504002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 20 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 20)

				if (20 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 20)) > 0 and var_11_0 < var_11_3 then
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
	Play1108504003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108504003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1108504004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.3

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1108504003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 12 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 12)

				if (12 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 12)) > 0 and var_15_0 < var_15_3 then
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
	Play1108504004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108504004
		arg_16_1.duration_ = 5.97

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108504005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1085ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1085ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1085ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1085ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1085ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1085ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1085ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -1.01, -5.83)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["1085ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1085ui_story == nil then
				arg_16_1.var_.characterEffect1085ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1085ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1085ui_story then
				arg_16_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_19_8 = 0
			local var_19_9 = 0.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(1108504004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 14 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 14)

				if (14 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 14)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb")

						arg_16_1:RecordAudio("1108504004", var_19_15)
						arg_16_1:RecordAudio("1108504004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb")
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
				actorName = "1085ui_story",
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
	Play1108504005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1108504005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1108504006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1085ui_story = arg_20_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_23_0 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				arg_20_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).z)
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles = arg_20_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				arg_20_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).z)
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles = arg_20_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_23_1 = arg_20_1.actors_["1085ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1085ui_story == nil then
				arg_20_1.var_.characterEffect1085ui_story = var_23_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_2 and not isNil(var_23_1) then
				if arg_20_1.var_.characterEffect1085ui_story and not isNil(var_23_1) then
					arg_20_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_2)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_2 and arg_20_1.time_ < 0 + var_23_2 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1085ui_story then
				arg_20_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_23_3 = 0
			local var_23_4 = 1.05

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_5 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(1108504005).content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 42 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_5) / 42)

				if (42 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_5) / 42)) > 0 and var_23_4 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_3 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_3
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_4, arg_20_1.talkMaxDuration)

			if var_23_3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_3 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_3) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_3 + var_23_8 and arg_20_1.time_ < var_23_3 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108504006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108504007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.35

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(1108504006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 14 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 14)

				if (14 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 14)) > 0 and var_27_0 < var_27_3 then
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
	Play1108504007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108504007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1108504008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.7

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(1108504007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 28 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 28)

				if (28 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 28)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1108504008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108504008
		arg_32_1.duration_ = 5.37

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1108504009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1085ui_story = arg_32_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).z)
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles = arg_32_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_32_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).z)
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles = arg_32_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1085ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1085ui_story == nil then
				arg_32_1.var_.characterEffect1085ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect1085ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1085ui_story then
				arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 0.25

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(1108504008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 10 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 10)

				if (10 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 10)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb")

						arg_32_1:RecordAudio("1108504008", var_35_11)
						arg_32_1:RecordAudio("1108504008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb")
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
				actorName = "1085ui_story",
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
	Play1108504009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108504009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1108504010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1085ui_story"]) and arg_36_1.var_.characterEffect1085ui_story == nil then
				arg_36_1.var_.characterEffect1085ui_story = arg_36_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1085ui_story"]) then
				if arg_36_1.var_.characterEffect1085ui_story and not isNil(arg_36_1.actors_["1085ui_story"]) then
					arg_36_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1085ui_story"]) and arg_36_1.var_.characterEffect1085ui_story then
				arg_36_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.425

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

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(1108504009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 17 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 17)

				if (17 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 17)) > 0 and var_39_2 < var_39_5 then
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
	Play1108504010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108504010
		arg_40_1.duration_ = 9

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1108504011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.bgs_.ST15 == nil then
				local var_43_0 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_43_0.name = "ST15"
				var_43_0.transform.parent = arg_40_1.stage_.transform
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_.ST15 = var_43_0
			end

			if 2 < arg_40_1.time_ and arg_40_1.time_ <= 2 + arg_43_0 then
				local var_43_1 = arg_40_1.bgs_.ST15

				arg_40_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_43_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_2 = var_43_1:GetComponent("SpriteRenderer")

				if var_43_2 and var_43_2.sprite then
					local var_43_3 = 2 * (var_43_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_43_1.transform.localScale = Vector3.New(var_43_3 / var_43_2.sprite.bounds.size.y < var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x and var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x or var_43_3 / var_43_2.sprite.bounds.size.y, var_43_3 / var_43_2.sprite.bounds.size.y < var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x and var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x or var_43_3 / var_43_2.sprite.bounds.size.y, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "ST15" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_4 = 4

			if 4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_4 + 0.3 and arg_40_1.time_ < var_43_4 + 0.3 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			local var_43_5 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_6 = 2

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 then
				local var_43_7 = Color.New(0, 0, 0)

				var_43_7.a = Mathf.Lerp(0, 1, (arg_40_1.time_ - var_43_5) / var_43_6)
				arg_40_1.mask_.color = var_43_7
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 then
				local var_43_8 = Color.New(0, 0, 0)

				var_43_8.a = 1
				arg_40_1.mask_.color = var_43_8
			end

			local var_43_9 = 2

			if 2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_10 = 2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 then
				local var_43_11 = Color.New(0, 0, 0)

				var_43_11.a = Mathf.Lerp(1, 0, (arg_40_1.time_ - var_43_9) / var_43_10)
				arg_40_1.mask_.color = var_43_11
			end

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 then
				local var_43_12 = Color.New(0, 0, 0)

				arg_40_1.mask_.enabled = false
				var_43_12.a = 0
				arg_40_1.mask_.color = var_43_12
			end

			local var_43_13 = arg_40_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_40_1.time_ and arg_40_1.time_ <= 1.96599999815226 + arg_43_0 then
				arg_40_1.var_.moveOldPos1085ui_story = var_43_13.localPosition
			end

			local var_43_14 = 0.001

			if 1.96599999815226 <= arg_40_1.time_ and arg_40_1.time_ < 1.96599999815226 + var_43_14 then
				var_43_13.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 1.96599999815226) / var_43_14)
				var_43_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_13.position).x, (manager.ui.mainCamera.transform.position - var_43_13.position).y, (manager.ui.mainCamera.transform.position - var_43_13.position).z)
				var_43_13.localEulerAngles.z = 0
				var_43_13.localEulerAngles.x = 0
				var_43_13.localEulerAngles = var_43_13.localEulerAngles
			end

			if arg_40_1.time_ >= 1.96599999815226 + var_43_14 and arg_40_1.time_ < 1.96599999815226 + var_43_14 + arg_43_0 then
				var_43_13.localPosition = Vector3.New(0, 100, 0)
				var_43_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_13.position).x, (manager.ui.mainCamera.transform.position - var_43_13.position).y, (manager.ui.mainCamera.transform.position - var_43_13.position).z)
				var_43_13.localEulerAngles.z = 0
				var_43_13.localEulerAngles.x = 0
				var_43_13.localEulerAngles = var_43_13.localEulerAngles
			end

			if 0.333333333333333 < arg_40_1.time_ and arg_40_1.time_ <= 0.333333333333333 + arg_43_0 then
				arg_40_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_43_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_17 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_17

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_17
						arg_40_1.bgmTxt2_.text = var_43_17
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.7 < arg_40_1.time_ and arg_40_1.time_ <= 1.7 + arg_43_0 then
				arg_40_1:AudioAction("play", "music", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_43_20 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

				if "" ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_20 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_20

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_20
						arg_40_1.bgmTxt2_.text = var_43_20
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_40_1.time_ and arg_40_1.time_ <= 0.333333333333333 + arg_43_0 then
				arg_40_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1.7 < arg_40_1.time_ and arg_40_1.time_ <= 1.7 + arg_43_0 then
				arg_40_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_23 = 4
			local var_43_24 = 0.675

			if 4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_25 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_25:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_40_1.dialogCg_.alpha = arg_46_0
				end))
				var_43_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_26 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1108504010).content)

				arg_40_1.text_.text = var_43_26

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_28 = 27 <= 0 and var_43_24 or var_43_24 * (utf8.len(var_43_26) / 27)

				if (27 <= 0 and var_43_24 or var_43_24 * (utf8.len(var_43_26) / 27)) > 0 and var_43_24 < var_43_28 then
					arg_40_1.talkMaxDuration = var_43_28
					var_43_23 = var_43_23 + 0.3

					if var_43_28 + var_43_23 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_28 + var_43_23
					end
				end

				arg_40_1.text_.text = var_43_26
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_29 = var_43_23 + 0.3
			local var_43_30 = math.max(var_43_24, arg_40_1.talkMaxDuration)

			if var_43_23 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_29 + var_43_30 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_29) / var_43_30

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_29 + var_43_30 and arg_40_1.time_ < var_43_29 + var_43_30 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play1108504011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108504011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108504012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.1

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1108504011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 44 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 44)

				if (44 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 44)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108504012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108504012
		arg_52_1.duration_ = 3.4

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108504013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1085ui_story = arg_52_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).z)
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles = arg_52_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_52_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).z)
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles = arg_52_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1085ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1085ui_story == nil then
				arg_52_1.var_.characterEffect1085ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1085ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1085ui_story then
				arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.15

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(1108504012)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 6 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 6)

				if (6 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 6)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb")

						arg_52_1:RecordAudio("1108504012", var_55_11)
						arg_52_1:RecordAudio("1108504012", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108504013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108504013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108504014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1085ui_story"]) and arg_56_1.var_.characterEffect1085ui_story == nil then
				arg_56_1.var_.characterEffect1085ui_story = arg_56_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1085ui_story"]) then
				if arg_56_1.var_.characterEffect1085ui_story and not isNil(arg_56_1.actors_["1085ui_story"]) then
					arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1085ui_story"]) and arg_56_1.var_.characterEffect1085ui_story then
				arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.75

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(1108504013).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 30 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 30)

				if (30 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 30)) > 0 and var_59_2 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_6 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_6 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_6

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_6 and arg_56_1.time_ < var_59_1 + var_59_6 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108504014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108504014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1108504015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.75

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(1108504014).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 30 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 30)

				if (30 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 30)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1108504015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108504015
		arg_64_1.duration_ = 3.03

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108504016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1085ui_story = arg_64_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1085ui_story"].transform.position).z)
				arg_64_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1085ui_story"].transform.localEulerAngles = arg_64_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_64_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1085ui_story"].transform.position).z)
				arg_64_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1085ui_story"].transform.localEulerAngles = arg_64_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1085ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1085ui_story == nil then
				arg_64_1.var_.characterEffect1085ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect1085ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1085ui_story then
				arg_64_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_67_4 = 0
			local var_67_5 = 0.175

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(1108504015)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 7 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 7)

				if (7 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 7)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb")

						arg_64_1:RecordAudio("1108504015", var_67_11)
						arg_64_1:RecordAudio("1108504015", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play1108504016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108504016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1108504017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1085ui_story = arg_68_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).z)
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles = arg_68_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).z)
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles = arg_68_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_71_1 = arg_68_1.actors_["1085ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1085ui_story == nil then
				arg_68_1.var_.characterEffect1085ui_story = var_71_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 and not isNil(var_71_1) then
				if arg_68_1.var_.characterEffect1085ui_story and not isNil(var_71_1) then
					arg_68_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_2)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1085ui_story then
				arg_68_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_68_1.time_ and arg_68_1.time_ <= 0.200000002980232 + arg_71_0 then
				arg_68_1:AudioAction("play", "effect", "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_71_4 = 0
			local var_71_5 = 0.675

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(1108504016).content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_8 = 27 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_6) / 27)

				if (27 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_6) / 27)) > 0 and var_71_5 < var_71_8 then
					arg_68_1.talkMaxDuration = var_71_8

					if var_71_8 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_6
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_9 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_9 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_9

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_9 and arg_68_1.time_ < var_71_4 + var_71_9 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108504017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1108504018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.75

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1108504017).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 30 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 30)

				if (30 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 30)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108504018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108504018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108504019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.75

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(1108504018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 30 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 30)

				if (30 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 30)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108504019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108504019
		arg_80_1.duration_ = 5.47

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108504020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1085ui_story = arg_80_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1085ui_story"].transform.position).z)
				arg_80_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1085ui_story"].transform.localEulerAngles = arg_80_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_80_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1085ui_story"].transform.position).z)
				arg_80_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1085ui_story"].transform.localEulerAngles = arg_80_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1085ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1085ui_story == nil then
				arg_80_1.var_.characterEffect1085ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect1085ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1085ui_story then
				arg_80_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_83_4 = 0
			local var_83_5 = 0.425

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(1108504019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 17 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 17)

				if (17 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 17)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb")

						arg_80_1:RecordAudio("1108504019", var_83_11)
						arg_80_1:RecordAudio("1108504019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb")
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

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108504020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108504021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1085ui_story"]) and arg_84_1.var_.characterEffect1085ui_story == nil then
				arg_84_1.var_.characterEffect1085ui_story = arg_84_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1085ui_story"]) then
				if arg_84_1.var_.characterEffect1085ui_story and not isNil(arg_84_1.actors_["1085ui_story"]) then
					arg_84_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1085ui_story"]) and arg_84_1.var_.characterEffect1085ui_story then
				arg_84_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.525

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(1108504020).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 21 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 21)

				if (21 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 21)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1108504021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108504021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108504022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.775

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
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

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(1108504021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 31 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 31)

				if (31 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 31)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1108504022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108504022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108504023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1085ui_story = arg_92_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1085ui_story"].transform.position).z)
				arg_92_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1085ui_story"].transform.localEulerAngles = arg_92_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1085ui_story"].transform.position).z)
				arg_92_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1085ui_story"].transform.localEulerAngles = arg_92_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_95_1 = 0
			local var_95_2 = 0.75

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(1108504022).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 30 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 30)

				if (30 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 30)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108504023
		arg_96_1.duration_ = 4.17

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1108504024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1085ui_story = arg_96_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1085ui_story"].transform.position).z)
				arg_96_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1085ui_story"].transform.localEulerAngles = arg_96_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_96_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1085ui_story"].transform.position).z)
				arg_96_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1085ui_story"].transform.localEulerAngles = arg_96_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1085ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1085ui_story == nil then
				arg_96_1.var_.characterEffect1085ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1085ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1085ui_story then
				arg_96_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_99_4 = 0
			local var_99_5 = 0.2

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(1108504023)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 8 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 8)

				if (8 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 8)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb")

						arg_96_1:RecordAudio("1108504023", var_99_11)
						arg_96_1:RecordAudio("1108504023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108504024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108504025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1085ui_story"]) and arg_100_1.var_.characterEffect1085ui_story == nil then
				arg_100_1.var_.characterEffect1085ui_story = arg_100_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1085ui_story"]) then
				if arg_100_1.var_.characterEffect1085ui_story and not isNil(arg_100_1.actors_["1085ui_story"]) then
					arg_100_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1085ui_story"]) and arg_100_1.var_.characterEffect1085ui_story then
				arg_100_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.95

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(1108504024).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 38 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 38)

				if (38 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 38)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1108504025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1108504025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1108504026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.925

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
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

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(1108504025).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 37 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 37)

				if (37 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 37)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1108504026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1108504026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1108504027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.7

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(1108504026).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 28 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 28)

				if (28 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 28)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1108504027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1108504027
		arg_112_1.duration_ = 2.27

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1108504028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1085ui_story = arg_112_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).z)
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles = arg_112_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_112_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).z)
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles = arg_112_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1085ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1085ui_story == nil then
				arg_112_1.var_.characterEffect1085ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect1085ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1085ui_story then
				arg_112_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_115_4 = 0
			local var_115_5 = 0.175

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(1108504027)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 7 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 7)

				if (7 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 7)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb")

						arg_112_1:RecordAudio("1108504027", var_115_11)
						arg_112_1:RecordAudio("1108504027", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1108504028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1108504029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1085ui_story = arg_116_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).z)
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles = arg_116_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).z)
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles = arg_116_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1085ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1085ui_story == nil then
				arg_116_1.var_.characterEffect1085ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1085ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_2)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1085ui_story then
				arg_116_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_119_3 = 0
			local var_119_4 = 0.925

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_5 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(1108504028).content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 37 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_5) / 37)

				if (37 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_5) / 37)) > 0 and var_119_4 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_3 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_3
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_4, arg_116_1.talkMaxDuration)

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_3) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_3 + var_119_8 and arg_116_1.time_ < var_119_3 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play1108504029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1108504029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1108504030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.85

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(1108504029).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)

				if (34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1108504030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1108504030
		arg_124_1.duration_ = 4.27

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1108504031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1085ui_story = arg_124_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1085ui_story"].transform.position).z)
				arg_124_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1085ui_story"].transform.localEulerAngles = arg_124_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_124_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1085ui_story"].transform.position).z)
				arg_124_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1085ui_story"].transform.localEulerAngles = arg_124_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_127_1 = arg_124_1.actors_["1085ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1085ui_story == nil then
				arg_124_1.var_.characterEffect1085ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect1085ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1085ui_story then
				arg_124_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_127_4 = 0
			local var_127_5 = 0.375

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(1108504030)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 15 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 15)

				if (15 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 15)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb")

						arg_124_1:RecordAudio("1108504030", var_127_11)
						arg_124_1:RecordAudio("1108504030", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb")
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
				actorName = "1085ui_story",
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
	Play1108504031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1108504031
		arg_128_1.duration_ = 7.83

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1108504032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.5

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(1108504031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 20 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 20)

				if (20 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 20)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb")

						arg_128_1:RecordAudio("1108504031", var_131_6)
						arg_128_1:RecordAudio("1108504031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1108504032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1108504032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1108504033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1085ui_story"]) and arg_132_1.var_.characterEffect1085ui_story == nil then
				arg_132_1.var_.characterEffect1085ui_story = arg_132_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1085ui_story"]) then
				if arg_132_1.var_.characterEffect1085ui_story and not isNil(arg_132_1.actors_["1085ui_story"]) then
					arg_132_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1085ui_story"]) and arg_132_1.var_.characterEffect1085ui_story then
				arg_132_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.55

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(1108504032).content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 22 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 22)

				if (22 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 22)) > 0 and var_135_2 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_6 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_6 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_6

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_6 and arg_132_1.time_ < var_135_1 + var_135_6 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1108504033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1108504033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1108504034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.975

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
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

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(1108504033).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 39 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 39)

				if (39 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 39)) > 0 and var_139_0 < var_139_3 then
					arg_136_1.talkMaxDuration = var_139_3

					if var_139_3 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_3 + 0
					end
				end

				arg_136_1.text_.text = var_139_1
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_4 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_4

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1108504034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1108504034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1108504035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1085ui_story = arg_140_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1085ui_story"].transform.position).z)
				arg_140_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1085ui_story"].transform.localEulerAngles = arg_140_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1085ui_story"].transform.position).z)
				arg_140_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1085ui_story"].transform.localEulerAngles = arg_140_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_143_1 = 0
			local var_143_2 = 0.825

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1108504034).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 33 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 33)

				if (33 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 33)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play1108504035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1108504035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1108504036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.8

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
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

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(1108504035).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 32 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 32)

				if (32 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 32)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1108504036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1108504036
		arg_148_1.duration_ = 7.3

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1108504037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1085ui_story = arg_148_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1085ui_story"].transform.position).z)
				arg_148_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1085ui_story"].transform.localEulerAngles = arg_148_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_148_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1085ui_story"].transform.position).z)
				arg_148_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1085ui_story"].transform.localEulerAngles = arg_148_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1085ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1085ui_story == nil then
				arg_148_1.var_.characterEffect1085ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect1085ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1085ui_story then
				arg_148_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_151_4 = 0
			local var_151_5 = 0.475

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(1108504036)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 19 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 19)

				if (19 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 19)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb")

						arg_148_1:RecordAudio("1108504036", var_151_11)
						arg_148_1:RecordAudio("1108504036", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1108504037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1108504038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1085ui_story"]) and arg_152_1.var_.characterEffect1085ui_story == nil then
				arg_152_1.var_.characterEffect1085ui_story = arg_152_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1085ui_story"]) then
				if arg_152_1.var_.characterEffect1085ui_story and not isNil(arg_152_1.actors_["1085ui_story"]) then
					arg_152_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1085ui_story"]) and arg_152_1.var_.characterEffect1085ui_story then
				arg_152_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_155_1 = 0
			local var_155_2 = 1.075

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(1108504037).content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 43 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 43)

				if (43 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 43)) > 0 and var_155_2 < var_155_5 then
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

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1108504038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1108504038
		arg_156_1.duration_ = 2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1108504039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1085ui_story = arg_156_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1085ui_story"].transform.position).z)
				arg_156_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1085ui_story"].transform.localEulerAngles = arg_156_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_156_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1085ui_story"].transform.position).z)
				arg_156_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1085ui_story"].transform.localEulerAngles = arg_156_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1085ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1085ui_story == nil then
				arg_156_1.var_.characterEffect1085ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1085ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1085ui_story then
				arg_156_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_4 = 0
			local var_159_5 = 0.175

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(1108504038)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 7 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 7)

				if (7 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 7)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb")

						arg_156_1:RecordAudio("1108504038", var_159_11)
						arg_156_1:RecordAudio("1108504038", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1108504039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1108504040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1085ui_story"]) and arg_160_1.var_.characterEffect1085ui_story == nil then
				arg_160_1.var_.characterEffect1085ui_story = arg_160_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1085ui_story"]) then
				if arg_160_1.var_.characterEffect1085ui_story and not isNil(arg_160_1.actors_["1085ui_story"]) then
					arg_160_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1085ui_story"]) and arg_160_1.var_.characterEffect1085ui_story then
				arg_160_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 1.2

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
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

				local var_163_3 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(1108504039).content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 48 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 48)

				if (48 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 48)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_6 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_6 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_6

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_6 and arg_160_1.time_ < var_163_1 + var_163_6 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1108504040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1108504040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1108504041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.9

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(1108504040).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 36 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 36)

				if (36 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 36)) > 0 and var_167_0 < var_167_3 then
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
	Play1108504041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1108504041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1108504042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 1.2

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(1108504041).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 48 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 48)

				if (48 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 48)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1108504042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1108504042
		arg_172_1.duration_ = 2.1

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1108504043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1085ui_story = arg_172_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1085ui_story"].transform.position).z)
				arg_172_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1085ui_story"].transform.localEulerAngles = arg_172_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_172_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1085ui_story"].transform.position).z)
				arg_172_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1085ui_story"].transform.localEulerAngles = arg_172_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_175_1 = arg_172_1.actors_["1085ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1085ui_story == nil then
				arg_172_1.var_.characterEffect1085ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 and not isNil(var_175_1) then
				if arg_172_1.var_.characterEffect1085ui_story and not isNil(var_175_1) then
					arg_172_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1085ui_story then
				arg_172_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_175_4 = 0
			local var_175_5 = 0.225

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:GetWordFromCfg(1108504042)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 9 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 9)

				if (9 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 9)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb")

						arg_172_1:RecordAudio("1108504042", var_175_11)
						arg_172_1:RecordAudio("1108504042", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1108504043
		arg_176_1.duration_ = 1

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"

			SetActive(arg_176_1.choicesGo_, true)

			for iter_177_0, iter_177_1 in ipairs(arg_176_1.choices_) do
				SetActive(iter_177_1.go, iter_177_0 <= 2)
			end

			arg_176_1.choices_[1].txt.text = arg_176_1:FormatText(StoryChoiceCfg[1636].name)
			arg_176_1.choices_[2].txt.text = arg_176_1:FormatText(StoryChoiceCfg[1637].name)
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1108504044(arg_176_1)
			end

			if arg_178_0 == 2 then
				arg_176_0:Play1108504046(arg_176_1)
			end

			arg_176_1:RecordChoiceLog(1108504043, 1636, 1637)
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1085ui_story"]) and arg_176_1.var_.characterEffect1085ui_story == nil then
				arg_176_1.var_.characterEffect1085ui_story = arg_176_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1085ui_story"]) then
				if arg_176_1.var_.characterEffect1085ui_story and not isNil(arg_176_1.actors_["1085ui_story"]) then
					arg_176_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1085ui_story"]) and arg_176_1.var_.characterEffect1085ui_story then
				arg_176_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_179_1 = 0

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			if arg_176_1.time_ >= var_179_1 + 0.6 and arg_176_1.time_ < var_179_1 + 0.6 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1108504044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1108504044
		arg_180_1.duration_ = 3.53

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1108504045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1085ui_story = arg_180_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1085ui_story"].transform.position).z)
				arg_180_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1085ui_story"].transform.localEulerAngles = arg_180_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_180_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1085ui_story"].transform.position).z)
				arg_180_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1085ui_story"].transform.localEulerAngles = arg_180_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1085ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1085ui_story == nil then
				arg_180_1.var_.characterEffect1085ui_story = var_183_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 and not isNil(var_183_1) then
				if arg_180_1.var_.characterEffect1085ui_story and not isNil(var_183_1) then
					arg_180_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1085ui_story then
				arg_180_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_183_4 = 0
			local var_183_5 = 0.325

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_6 = arg_180_1:GetWordFromCfg(1108504044)
				local var_183_7 = arg_180_1:FormatText(var_183_6.content)

				arg_180_1.text_.text = var_183_7

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_9 = 13 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 13)

				if (13 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 13)) > 0 and var_183_5 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_4
					end
				end

				arg_180_1.text_.text = var_183_7
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb") / 1000

					if var_183_10 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_4
					end

					if var_183_6.prefab_name ~= "" and arg_180_1.actors_[var_183_6.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_6.prefab_name].transform, "story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb")

						arg_180_1:RecordAudio("1108504044", var_183_11)
						arg_180_1:RecordAudio("1108504044", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb")
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
				actorName = "1085ui_story",
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
	Play1108504045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1108504045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1108504048(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1085ui_story"]) and arg_184_1.var_.characterEffect1085ui_story == nil then
				arg_184_1.var_.characterEffect1085ui_story = arg_184_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1085ui_story"]) then
				if arg_184_1.var_.characterEffect1085ui_story and not isNil(arg_184_1.actors_["1085ui_story"]) then
					arg_184_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1085ui_story"]) and arg_184_1.var_.characterEffect1085ui_story then
				arg_184_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_187_1 = 0
			local var_187_2 = 0.6

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(1108504045).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 24 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 24)

				if (24 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 24)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1108504048 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1108504048
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1108504049(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 1.025

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(1108504048).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 41 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 41)

				if (41 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 41)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1108504049 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1108504049
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1108504050(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 1.1

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

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(1108504049).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 44 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 44)

				if (44 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 44)) > 0 and var_195_0 < var_195_3 then
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
	Play1108504050 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1108504050
		arg_196_1.duration_ = 4.13

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1108504051(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1085ui_story = arg_196_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_199_0 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				arg_196_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1085ui_story"].transform.position).z)
				arg_196_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1085ui_story"].transform.localEulerAngles = arg_196_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				arg_196_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_196_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1085ui_story"].transform.position).z)
				arg_196_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1085ui_story"].transform.localEulerAngles = arg_196_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_199_1 = arg_196_1.actors_["1085ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1085ui_story == nil then
				arg_196_1.var_.characterEffect1085ui_story = var_199_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_2 and not isNil(var_199_1) then
				if arg_196_1.var_.characterEffect1085ui_story and not isNil(var_199_1) then
					arg_196_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_2 and arg_196_1.time_ < 0 + var_199_2 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1085ui_story then
				arg_196_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_4 = 0
			local var_199_5 = 0.325

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(1108504050)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 13 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 13)

				if (13 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 13)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb")

						arg_196_1:RecordAudio("1108504050", var_199_11)
						arg_196_1:RecordAudio("1108504050", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play1108504051 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1108504051
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1108504052(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1085ui_story"]) and arg_200_1.var_.characterEffect1085ui_story == nil then
				arg_200_1.var_.characterEffect1085ui_story = arg_200_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1085ui_story"]) then
				if arg_200_1.var_.characterEffect1085ui_story and not isNil(arg_200_1.actors_["1085ui_story"]) then
					arg_200_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1085ui_story"]) and arg_200_1.var_.characterEffect1085ui_story then
				arg_200_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_203_1 = 0
			local var_203_2 = 0.825

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

				local var_203_3 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(1108504051).content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 33 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 33)

				if (33 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 33)) > 0 and var_203_2 < var_203_5 then
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
	Play1108504052 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1108504052
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1108504053(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.9

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(1108504052).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 36 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 36)

				if (36 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 36)) > 0 and var_207_0 < var_207_3 then
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
	Play1108504053 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1108504053
		arg_208_1.duration_ = 6.5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1108504054(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1085ui_story = arg_208_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_211_0 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 then
				arg_208_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_208_1.time_ - 0) / var_211_0)
				arg_208_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1085ui_story"].transform.position).z)
				arg_208_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1085ui_story"].transform.localEulerAngles = arg_208_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 then
				arg_208_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_208_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1085ui_story"].transform.position).z)
				arg_208_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1085ui_story"].transform.localEulerAngles = arg_208_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_211_1 = arg_208_1.actors_["1085ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect1085ui_story == nil then
				arg_208_1.var_.characterEffect1085ui_story = var_211_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_2 and not isNil(var_211_1) then
				if arg_208_1.var_.characterEffect1085ui_story and not isNil(var_211_1) then
					arg_208_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_2 and arg_208_1.time_ < 0 + var_211_2 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect1085ui_story then
				arg_208_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_211_4 = 0
			local var_211_5 = 0.45

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_6 = arg_208_1:GetWordFromCfg(1108504053)
				local var_211_7 = arg_208_1:FormatText(var_211_6.content)

				arg_208_1.text_.text = var_211_7

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_9 = 18 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 18)

				if (18 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 18)) > 0 and var_211_5 < var_211_9 then
					arg_208_1.talkMaxDuration = var_211_9

					if var_211_9 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_4
					end
				end

				arg_208_1.text_.text = var_211_7
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb") ~= 0 then
					local var_211_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb") / 1000

					if var_211_10 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_4
					end

					if var_211_6.prefab_name ~= "" and arg_208_1.actors_[var_211_6.prefab_name] ~= nil then
						local var_211_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_6.prefab_name].transform, "story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb")

						arg_208_1:RecordAudio("1108504053", var_211_11)
						arg_208_1:RecordAudio("1108504053", var_211_11)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_12 = math.max(var_211_5, arg_208_1.talkMaxDuration)

			if var_211_4 <= arg_208_1.time_ and arg_208_1.time_ < var_211_4 + var_211_12 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_4) / var_211_12

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_4 + var_211_12 and arg_208_1.time_ < var_211_4 + var_211_12 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play1108504054 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1108504054
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1108504055(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1085ui_story"]) and arg_212_1.var_.characterEffect1085ui_story == nil then
				arg_212_1.var_.characterEffect1085ui_story = arg_212_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1085ui_story"]) then
				if arg_212_1.var_.characterEffect1085ui_story and not isNil(arg_212_1.actors_["1085ui_story"]) then
					arg_212_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_0)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1085ui_story"]) and arg_212_1.var_.characterEffect1085ui_story then
				arg_212_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_215_1 = 0
			local var_215_2 = 0.175

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_3 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(1108504054).content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 7 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 7)

				if (7 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 7)) > 0 and var_215_2 < var_215_5 then
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

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1108504055 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1108504055
		arg_216_1.duration_ = 6

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1108504056(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_9000

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1085ui_story = arg_216_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1085ui_story"].transform.position).z)
				arg_216_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1085ui_story"].transform.localEulerAngles = arg_216_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1085ui_story"].transform.position).z)
				arg_216_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1085ui_story"].transform.localEulerAngles = arg_216_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_219_1 = 0

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_2 = 1

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = Color.New(1, 1, 1)

				var_219_3.a = Mathf.Lerp(1, 0, (arg_216_1.time_ - var_219_1) / var_219_2)
				arg_216_1.mask_.color = var_219_3
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				local var_219_4 = Color.New(1, 1, 1)

				arg_216_1.mask_.enabled = false
				var_219_4.a = 0
				arg_216_1.mask_.color = var_219_4
			end

			local var_219_5 = arg_216_1.bgs_.ST15.transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPosST15 = var_219_5.localPosition
			end

			local var_219_6 = 3

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_6 then
				var_219_5.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPosST15, Vector3.New(0, 1, 9), (arg_216_1.time_ - 0) / var_219_6)
			end

			if arg_216_1.time_ >= 0 + var_219_6 and arg_216_1.time_ < 0 + var_219_6 + arg_219_0 then
				var_219_5.localPosition = Vector3.New(0, 1, 9)
			end

			if 1.23333333333333 < arg_216_1.time_ and arg_216_1.time_ <= 1.23333333333333 + arg_219_0 then
				local var_219_7 = arg_216_1.var_.effectbenpaoshatan1

				if not arg_216_1.var_.effectbenpaoshatan1 then
					var_219_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_219_7.name = "benpaoshatan1"
					arg_216_1.var_.effectbenpaoshatan1 = var_219_7
				else
					var_219_7.transform:SetParent(var_219_9000)
				end

				var_219_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_219_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3 < arg_216_1.time_ and arg_216_1.time_ <= 3 + arg_219_0 then
				if arg_216_1.var_.effectbenpaoshatan1 then
					Object.Destroy(arg_216_1.var_.effectbenpaoshatan1)

					arg_216_1.var_.effectbenpaoshatan1 = nil
				end
			end

			if 1.23333333333333 < arg_216_1.time_ and arg_216_1.time_ <= 1.23333333333333 + arg_219_0 then
				arg_216_1:AudioAction("play", "effect", "se_story_side_1085", "se_story_side_1085_run_sand", "")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:AudioAction("play", "effect", "se_story_145", "se_story_145_magic_whoosh02", "")
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_12 = 1
			local var_219_13 = 1.05

			if 1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_12 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_14 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_14:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_15 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(1108504055).content)

				arg_216_1.text_.text = var_219_15

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_17 = 42 <= 0 and var_219_13 or var_219_13 * (utf8.len(var_219_15) / 42)

				if (42 <= 0 and var_219_13 or var_219_13 * (utf8.len(var_219_15) / 42)) > 0 and var_219_13 < var_219_17 then
					arg_216_1.talkMaxDuration = var_219_17
					var_219_12 = var_219_12 + 0.3

					if var_219_17 + var_219_12 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_17 + var_219_12
					end
				end

				arg_216_1.text_.text = var_219_15
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_18 = var_219_12 + 0.3
			local var_219_19 = math.max(var_219_13, arg_216_1.talkMaxDuration)

			if var_219_12 + 0.3 <= arg_216_1.time_ and arg_216_1.time_ < var_219_18 + var_219_19 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_18) / var_219_19

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_18 + var_219_19 and arg_216_1.time_ < var_219_18 + var_219_19 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "ST15",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play1108504056 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1108504056
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1108504057(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.825

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(1108504056).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 33 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 33)

				if (33 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 33)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1108504057 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1108504057
		arg_226_1.duration_ = 5.2

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1108504058(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1085ui_story = arg_226_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1085ui_story"].transform.position).z)
				arg_226_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1085ui_story"].transform.localEulerAngles = arg_226_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_226_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1085ui_story"].transform.position).z)
				arg_226_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1085ui_story"].transform.localEulerAngles = arg_226_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["1085ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1085ui_story == nil then
				arg_226_1.var_.characterEffect1085ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 and not isNil(var_229_1) then
				if arg_226_1.var_.characterEffect1085ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1085ui_story then
				arg_226_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.225

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(1108504057)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 9 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 9)

				if (9 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 9)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb")

						arg_226_1:RecordAudio("1108504057", var_229_11)
						arg_226_1:RecordAudio("1108504057", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play1108504058 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1108504058
		arg_230_1.duration_ = 9

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1108504059(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 2 < arg_230_1.time_ and arg_230_1.time_ <= 2 + arg_233_0 then
				local var_233_0 = arg_230_1.bgs_.ST12

				arg_230_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_233_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_1 = var_233_0:GetComponent("SpriteRenderer")

				if var_233_1 and var_233_1.sprite then
					local var_233_2 = 2 * (var_233_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_233_0.transform.localScale = Vector3.New(var_233_2 / var_233_1.sprite.bounds.size.y < var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x and var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x or var_233_2 / var_233_1.sprite.bounds.size.y, var_233_2 / var_233_1.sprite.bounds.size.y < var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x and var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x or var_233_2 / var_233_1.sprite.bounds.size.y, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST12" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_3 = 4

			if 4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			if arg_230_1.time_ >= var_233_3 + 0.3 and arg_230_1.time_ < var_233_3 + 0.3 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			local var_233_4 = 0

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_5 = 2

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_5 then
				local var_233_6 = Color.New(0, 0, 0)

				var_233_6.a = Mathf.Lerp(0, 1, (arg_230_1.time_ - var_233_4) / var_233_5)
				arg_230_1.mask_.color = var_233_6
			end

			if arg_230_1.time_ >= var_233_4 + var_233_5 and arg_230_1.time_ < var_233_4 + var_233_5 + arg_233_0 then
				local var_233_7 = Color.New(0, 0, 0)

				var_233_7.a = 1
				arg_230_1.mask_.color = var_233_7
			end

			local var_233_8 = 2

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_9 = 2

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_9 then
				local var_233_10 = Color.New(0, 0, 0)

				var_233_10.a = Mathf.Lerp(1, 0, (arg_230_1.time_ - var_233_8) / var_233_9)
				arg_230_1.mask_.color = var_233_10
			end

			if arg_230_1.time_ >= var_233_8 + var_233_9 and arg_230_1.time_ < var_233_8 + var_233_9 + arg_233_0 then
				local var_233_11 = Color.New(0, 0, 0)

				arg_230_1.mask_.enabled = false
				var_233_11.a = 0
				arg_230_1.mask_.color = var_233_11
			end

			local var_233_12 = arg_230_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_230_1.time_ and arg_230_1.time_ <= 1.96599999815226 + arg_233_0 then
				arg_230_1.var_.moveOldPos1085ui_story = var_233_12.localPosition
			end

			local var_233_13 = 0.001

			if 1.96599999815226 <= arg_230_1.time_ and arg_230_1.time_ < 1.96599999815226 + var_233_13 then
				var_233_12.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 1.96599999815226) / var_233_13)
				var_233_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_12.position).x, (manager.ui.mainCamera.transform.position - var_233_12.position).y, (manager.ui.mainCamera.transform.position - var_233_12.position).z)
				var_233_12.localEulerAngles.z = 0
				var_233_12.localEulerAngles.x = 0
				var_233_12.localEulerAngles = var_233_12.localEulerAngles
			end

			if arg_230_1.time_ >= 1.96599999815226 + var_233_13 and arg_230_1.time_ < 1.96599999815226 + var_233_13 + arg_233_0 then
				var_233_12.localPosition = Vector3.New(0, 100, 0)
				var_233_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_12.position).x, (manager.ui.mainCamera.transform.position - var_233_12.position).y, (manager.ui.mainCamera.transform.position - var_233_12.position).z)
				var_233_12.localEulerAngles.z = 0
				var_233_12.localEulerAngles.x = 0
				var_233_12.localEulerAngles = var_233_12.localEulerAngles
			end

			local var_233_14 = arg_230_1.actors_["1085ui_story"]

			if 1.96599999815226 < arg_230_1.time_ and arg_230_1.time_ <= 1.96599999815226 + arg_233_0 and not isNil(var_233_14) and arg_230_1.var_.characterEffect1085ui_story == nil then
				arg_230_1.var_.characterEffect1085ui_story = var_233_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_15 = 0.034000001847744

			if 1.96599999815226 <= arg_230_1.time_ and arg_230_1.time_ < 1.96599999815226 + var_233_15 and not isNil(var_233_14) then
				if arg_230_1.var_.characterEffect1085ui_story and not isNil(var_233_14) then
					arg_230_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 1.96599999815226) / var_233_15)
				end
			end

			if arg_230_1.time_ >= 1.96599999815226 + var_233_15 and arg_230_1.time_ < 1.96599999815226 + var_233_15 + arg_233_0 and not isNil(var_233_14) and arg_230_1.var_.characterEffect1085ui_story then
				arg_230_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0.266666666666667 < arg_230_1.time_ and arg_230_1.time_ <= 0.266666666666667 + arg_233_0 then
				arg_230_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_233_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_230_1.bgmTxt_.text ~= var_233_18 and arg_230_1.bgmTxt_.text ~= "" then
						if arg_230_1.bgmTxt2_.text ~= "" then
							arg_230_1.bgmTxt_.text = arg_230_1.bgmTxt2_.text
						end

						arg_230_1.bgmTxt2_.text = var_233_18

						arg_230_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_230_1.bgmTxt_.text = var_233_18
						arg_230_1.bgmTxt2_.text = var_233_18
					end

					if arg_230_1.bgmTimer then
						arg_230_1.bgmTimer:Stop()

						arg_230_1.bgmTimer = nil
					end

					if arg_230_1.settingData.show_music_name == 1 then
						arg_230_1.musicController:SetSelectedState("show")
						arg_230_1.musicAnimator_:Play("open", 0, 0)

						if arg_230_1.settingData.music_time ~= 0 then
							arg_230_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_230_1.settingData.music_time), function()
								if arg_230_1 == nil or isNil(arg_230_1.bgmTxt_) then
									return
								end

								arg_230_1.musicController:SetSelectedState("hide")
								arg_230_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.66666666666667 < arg_230_1.time_ and arg_230_1.time_ <= 1.66666666666667 + arg_233_0 then
				arg_230_1:AudioAction("play", "music", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_233_21 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if "" ~= "" then
					if arg_230_1.bgmTxt_.text ~= var_233_21 and arg_230_1.bgmTxt_.text ~= "" then
						if arg_230_1.bgmTxt2_.text ~= "" then
							arg_230_1.bgmTxt_.text = arg_230_1.bgmTxt2_.text
						end

						arg_230_1.bgmTxt2_.text = var_233_21

						arg_230_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_230_1.bgmTxt_.text = var_233_21
						arg_230_1.bgmTxt2_.text = var_233_21
					end

					if arg_230_1.bgmTimer then
						arg_230_1.bgmTimer:Stop()

						arg_230_1.bgmTimer = nil
					end

					if arg_230_1.settingData.show_music_name == 1 then
						arg_230_1.musicController:SetSelectedState("show")
						arg_230_1.musicAnimator_:Play("open", 0, 0)

						if arg_230_1.settingData.music_time ~= 0 then
							arg_230_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_230_1.settingData.music_time), function()
								if arg_230_1 == nil or isNil(arg_230_1.bgmTxt_) then
									return
								end

								arg_230_1.musicController:SetSelectedState("hide")
								arg_230_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_230_1.time_ and arg_230_1.time_ <= 0.266666666666667 + arg_233_0 then
				arg_230_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 1.66666666666667 < arg_230_1.time_ and arg_230_1.time_ <= 1.66666666666667 + arg_233_0 then
				arg_230_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_24 = 4
			local var_233_25 = 1.3

			if 4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_24 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_26 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_26:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_230_1.dialogCg_.alpha = arg_236_0
				end))
				var_233_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_27 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(1108504058).content)

				arg_230_1.text_.text = var_233_27

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_29 = 52 <= 0 and var_233_25 or var_233_25 * (utf8.len(var_233_27) / 52)

				if (52 <= 0 and var_233_25 or var_233_25 * (utf8.len(var_233_27) / 52)) > 0 and var_233_25 < var_233_29 then
					arg_230_1.talkMaxDuration = var_233_29
					var_233_24 = var_233_24 + 0.3

					if var_233_29 + var_233_24 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_29 + var_233_24
					end
				end

				arg_230_1.text_.text = var_233_27
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_30 = var_233_24 + 0.3
			local var_233_31 = math.max(var_233_25, arg_230_1.talkMaxDuration)

			if var_233_24 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_30 + var_233_31 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_30) / var_233_31

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_30 + var_233_31 and arg_230_1.time_ < var_233_30 + var_233_31 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play1108504059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1108504059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1108504060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.275

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1108504059).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 11 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 11)

				if (11 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 11)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1108504060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1108504060
		arg_242_1.duration_ = 4.03

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1108504061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1085ui_story = arg_242_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1085ui_story"].transform.position).z)
				arg_242_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1085ui_story"].transform.localEulerAngles = arg_242_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_242_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1085ui_story"].transform.position).z)
				arg_242_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1085ui_story"].transform.localEulerAngles = arg_242_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1085ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1085ui_story == nil then
				arg_242_1.var_.characterEffect1085ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1085ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1085ui_story then
				arg_242_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_245_4 = 0
			local var_245_5 = 0.35

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(1108504060)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 14 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 14)

				if (14 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 14)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb")

						arg_242_1:RecordAudio("1108504060", var_245_11)
						arg_242_1:RecordAudio("1108504060", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1108504061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1108504061
		arg_246_1.duration_ = 3.6

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1108504062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_249_0 = 0
			local var_249_1 = 0.275

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_2 = arg_246_1:GetWordFromCfg(1108504061)
				local var_249_3 = arg_246_1:FormatText(var_249_2.content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 11 <= 0 and var_249_1 or var_249_1 * (utf8.len(var_249_3) / 11)

				if (11 <= 0 and var_249_1 or var_249_1 * (utf8.len(var_249_3) / 11)) > 0 and var_249_1 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb") ~= 0 then
					local var_249_6 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb") / 1000

					if var_249_6 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_0
					end

					if var_249_2.prefab_name ~= "" and arg_246_1.actors_[var_249_2.prefab_name] ~= nil then
						local var_249_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_2.prefab_name].transform, "story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb")

						arg_246_1:RecordAudio("1108504061", var_249_7)
						arg_246_1:RecordAudio("1108504061", var_249_7)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_8 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_8 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_8

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_8 and arg_246_1.time_ < var_249_0 + var_249_8 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1108504062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1108504062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1108504063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1085ui_story"]) and arg_250_1.var_.characterEffect1085ui_story == nil then
				arg_250_1.var_.characterEffect1085ui_story = arg_250_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1085ui_story"]) then
				if arg_250_1.var_.characterEffect1085ui_story and not isNil(arg_250_1.actors_["1085ui_story"]) then
					arg_250_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1085ui_story"]) and arg_250_1.var_.characterEffect1085ui_story then
				arg_250_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_253_1 = 0
			local var_253_2 = 0.6

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(1108504062).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 24 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 24)

				if (24 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 24)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1108504063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1108504063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1108504064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1085ui_story = arg_254_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1085ui_story"].transform.position).z)
				arg_254_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1085ui_story"].transform.localEulerAngles = arg_254_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1085ui_story"].transform.position).z)
				arg_254_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1085ui_story"].transform.localEulerAngles = arg_254_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_257_1 = 0
			local var_257_2 = 0.575

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1108504063).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 23 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 23)

				if (23 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 23)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play1108504064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1108504064
		arg_258_1.duration_ = 2.03

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1108504065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1085ui_story = arg_258_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1085ui_story"].transform.position).z)
				arg_258_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1085ui_story"].transform.localEulerAngles = arg_258_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_258_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1085ui_story"].transform.position).z)
				arg_258_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1085ui_story"].transform.localEulerAngles = arg_258_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1085ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1085ui_story == nil then
				arg_258_1.var_.characterEffect1085ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1085ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1085ui_story then
				arg_258_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_261_4 = 0
			local var_261_5 = 0.125

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_6 = arg_258_1:GetWordFromCfg(1108504064)
				local var_261_7 = arg_258_1:FormatText(var_261_6.content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 5 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 5)

				if (5 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 5)) > 0 and var_261_5 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb") ~= 0 then
					local var_261_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb") / 1000

					if var_261_10 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_4
					end

					if var_261_6.prefab_name ~= "" and arg_258_1.actors_[var_261_6.prefab_name] ~= nil then
						local var_261_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_6.prefab_name].transform, "story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb")

						arg_258_1:RecordAudio("1108504064", var_261_11)
						arg_258_1:RecordAudio("1108504064", var_261_11)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_12 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_12 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_12

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_12 and arg_258_1.time_ < var_261_4 + var_261_12 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1108504065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1108504065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1108504066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1085ui_story"]) and arg_262_1.var_.characterEffect1085ui_story == nil then
				arg_262_1.var_.characterEffect1085ui_story = arg_262_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1085ui_story"]) then
				if arg_262_1.var_.characterEffect1085ui_story and not isNil(arg_262_1.actors_["1085ui_story"]) then
					arg_262_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1085ui_story"]) and arg_262_1.var_.characterEffect1085ui_story then
				arg_262_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_265_1 = 0
			local var_265_2 = 0.75

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(1108504065).content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 30 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 30)

				if (30 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 30)) > 0 and var_265_2 < var_265_5 then
					arg_262_1.talkMaxDuration = var_265_5

					if var_265_5 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_6 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_6 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_6

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_6 and arg_262_1.time_ < var_265_1 + var_265_6 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1108504066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1108504066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1108504067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.65

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1108504066).content)

				arg_266_1.text_.text = var_269_1

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_3 = 26 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 26)

				if (26 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 26)) > 0 and var_269_0 < var_269_3 then
					arg_266_1.talkMaxDuration = var_269_3

					if var_269_3 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_3 + 0
					end
				end

				arg_266_1.text_.text = var_269_1
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_4 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_4

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1108504067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1108504067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1108504068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1085ui_story = arg_270_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1085ui_story"].transform.position).z)
				arg_270_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1085ui_story"].transform.localEulerAngles = arg_270_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1085ui_story"].transform.position).z)
				arg_270_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1085ui_story"].transform.localEulerAngles = arg_270_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_273_1 = 0
			local var_273_2 = 1.2

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(1108504067).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 48 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 48)

				if (48 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 48)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1108504068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1108504068
		arg_274_1.duration_ = 3.37

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1108504069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1085ui_story = arg_274_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1085ui_story"].transform.position).z)
				arg_274_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1085ui_story"].transform.localEulerAngles = arg_274_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_274_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1085ui_story"].transform.position).z)
				arg_274_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1085ui_story"].transform.localEulerAngles = arg_274_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["1085ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1085ui_story == nil then
				arg_274_1.var_.characterEffect1085ui_story = var_277_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 and not isNil(var_277_1) then
				if arg_274_1.var_.characterEffect1085ui_story and not isNil(var_277_1) then
					arg_274_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1085ui_story then
				arg_274_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_277_4 = 0
			local var_277_5 = 0.275

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_6 = arg_274_1:GetWordFromCfg(1108504068)
				local var_277_7 = arg_274_1:FormatText(var_277_6.content)

				arg_274_1.text_.text = var_277_7

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 11 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 11)

				if (11 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 11)) > 0 and var_277_5 < var_277_9 then
					arg_274_1.talkMaxDuration = var_277_9

					if var_277_9 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_7
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb") ~= 0 then
					local var_277_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb") / 1000

					if var_277_10 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_4
					end

					if var_277_6.prefab_name ~= "" and arg_274_1.actors_[var_277_6.prefab_name] ~= nil then
						local var_277_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_6.prefab_name].transform, "story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb")

						arg_274_1:RecordAudio("1108504068", var_277_11)
						arg_274_1:RecordAudio("1108504068", var_277_11)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_12 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_12 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_12

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_12 and arg_274_1.time_ < var_277_4 + var_277_12 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play1108504069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1108504069
		arg_278_1.duration_ = 6.3

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1108504070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if arg_278_1.bgs_.STblack == nil then
				local var_281_0 = Object.Instantiate(arg_278_1.paintGo_)

				var_281_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_281_0.name = "STblack"
				var_281_0.transform.parent = arg_278_1.stage_.transform
				var_281_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.bgs_.STblack = var_281_0
			end

			if 3 < arg_278_1.time_ and arg_278_1.time_ <= 3 + arg_281_0 then
				local var_281_1 = arg_278_1.bgs_.STblack

				arg_278_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_2 = var_281_1:GetComponent("SpriteRenderer")

				if var_281_2 and var_281_2.sprite then
					local var_281_3 = 2 * (var_281_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_1.transform.localScale = Vector3.New(var_281_3 / var_281_2.sprite.bounds.size.y < var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x and var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x or var_281_3 / var_281_2.sprite.bounds.size.y, var_281_3 / var_281_2.sprite.bounds.size.y < var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x and var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x or var_281_3 / var_281_2.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "STblack" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_4 = 5.999999999999

			if 5.999999999999 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= var_281_4 + 0.3 and arg_278_1.time_ < var_281_4 + 0.3 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_5 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_6 = 3

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_6 then
				local var_281_7 = Color.New(0, 0, 0)

				var_281_7.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - var_281_5) / var_281_6)
				arg_278_1.mask_.color = var_281_7
			end

			if arg_278_1.time_ >= var_281_5 + var_281_6 and arg_278_1.time_ < var_281_5 + var_281_6 + arg_281_0 then
				local var_281_8 = Color.New(0, 0, 0)

				var_281_8.a = 1
				arg_278_1.mask_.color = var_281_8
			end

			local var_281_9 = 3

			if 3 < arg_278_1.time_ and arg_278_1.time_ <= var_281_9 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_10 = 3

			if var_281_9 <= arg_278_1.time_ and arg_278_1.time_ < var_281_9 + var_281_10 then
				local var_281_11 = Color.New(0, 0, 0)

				var_281_11.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_9) / var_281_10)
				arg_278_1.mask_.color = var_281_11
			end

			if arg_278_1.time_ >= var_281_9 + var_281_10 and arg_278_1.time_ < var_281_9 + var_281_10 + arg_281_0 then
				local var_281_12 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_12.a = 0
				arg_278_1.mask_.color = var_281_12
			end

			local var_281_13 = arg_278_1.actors_["1085ui_story"].transform

			if 2.96599999815226 < arg_278_1.time_ and arg_278_1.time_ <= 2.96599999815226 + arg_281_0 then
				arg_278_1.var_.moveOldPos1085ui_story = var_281_13.localPosition
			end

			local var_281_14 = 0.001

			if 2.96599999815226 <= arg_278_1.time_ and arg_278_1.time_ < 2.96599999815226 + var_281_14 then
				var_281_13.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 2.96599999815226) / var_281_14)
				var_281_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_13.position).x, (manager.ui.mainCamera.transform.position - var_281_13.position).y, (manager.ui.mainCamera.transform.position - var_281_13.position).z)
				var_281_13.localEulerAngles.z = 0
				var_281_13.localEulerAngles.x = 0
				var_281_13.localEulerAngles = var_281_13.localEulerAngles
			end

			if arg_278_1.time_ >= 2.96599999815226 + var_281_14 and arg_278_1.time_ < 2.96599999815226 + var_281_14 + arg_281_0 then
				var_281_13.localPosition = Vector3.New(0, 100, 0)
				var_281_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_13.position).x, (manager.ui.mainCamera.transform.position - var_281_13.position).y, (manager.ui.mainCamera.transform.position - var_281_13.position).z)
				var_281_13.localEulerAngles.z = 0
				var_281_13.localEulerAngles.x = 0
				var_281_13.localEulerAngles = var_281_13.localEulerAngles
			end

			local var_281_15 = arg_278_1.actors_["1085ui_story"]

			if 2.96599999815226 < arg_278_1.time_ and arg_278_1.time_ <= 2.96599999815226 + arg_281_0 and not isNil(var_281_15) and arg_278_1.var_.characterEffect1085ui_story == nil then
				arg_278_1.var_.characterEffect1085ui_story = var_281_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_16 = 0.034000001847744

			if 2.96599999815226 <= arg_278_1.time_ and arg_278_1.time_ < 2.96599999815226 + var_281_16 and not isNil(var_281_15) then
				if arg_278_1.var_.characterEffect1085ui_story and not isNil(var_281_15) then
					arg_278_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 2.96599999815226) / var_281_16)
				end
			end

			if arg_278_1.time_ >= 2.96599999815226 + var_281_16 and arg_278_1.time_ < 2.96599999815226 + var_281_16 + arg_281_0 and not isNil(var_281_15) and arg_278_1.var_.characterEffect1085ui_story then
				arg_278_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_281_17 = 4.53333333333333
			local var_281_18 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504069", "story_v_side_new_1108504.awb") / 1000

			if var_281_18 > 0 and 1 < var_281_18 and var_281_18 + var_281_17 > arg_278_1.duration_ then
				arg_278_1.duration_ = var_281_18 + var_281_17
			end

			if var_281_17 < arg_278_1.time_ and arg_278_1.time_ <= var_281_17 + arg_281_0 then
				arg_278_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504069", "story_v_side_new_1108504.awb")
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504069,
				charCount = 7,
				enableLayoutChange = true,
				duration = 0.466666666666667,
				groupID = "shikoudixinlian1",
				startTime = 4.53333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play1108504070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1108504070
		arg_282_1.duration_ = 9.1

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1108504071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if arg_282_1.bgs_.ST20 == nil then
				local var_285_0 = Object.Instantiate(arg_282_1.paintGo_)

				var_285_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST20")
				var_285_0.name = "ST20"
				var_285_0.transform.parent = arg_282_1.stage_.transform
				var_285_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.bgs_.ST20 = var_285_0
			end

			if 2 < arg_282_1.time_ and arg_282_1.time_ <= 2 + arg_285_0 then
				local var_285_1 = arg_282_1.bgs_.ST20

				arg_282_1.bgs_.ST20.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_285_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_2 = var_285_1:GetComponent("SpriteRenderer")

				if var_285_2 and var_285_2.sprite then
					local var_285_3 = 2 * (var_285_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_285_1.transform.localScale = Vector3.New(var_285_3 / var_285_2.sprite.bounds.size.y < var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x and var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x or var_285_3 / var_285_2.sprite.bounds.size.y, var_285_3 / var_285_2.sprite.bounds.size.y < var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x and var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x or var_285_3 / var_285_2.sprite.bounds.size.y, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "ST20" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_4 = 4

			if 4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			if arg_282_1.time_ >= var_285_4 + 0.3 and arg_282_1.time_ < var_285_4 + 0.3 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end

			local var_285_5 = 0

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_6 = 2

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_6 then
				local var_285_7 = Color.New(0, 0, 0)

				var_285_7.a = Mathf.Lerp(0, 1, (arg_282_1.time_ - var_285_5) / var_285_6)
				arg_282_1.mask_.color = var_285_7
			end

			if arg_282_1.time_ >= var_285_5 + var_285_6 and arg_282_1.time_ < var_285_5 + var_285_6 + arg_285_0 then
				local var_285_8 = Color.New(0, 0, 0)

				var_285_8.a = 1
				arg_282_1.mask_.color = var_285_8
			end

			local var_285_9 = 2

			if 2 < arg_282_1.time_ and arg_282_1.time_ <= var_285_9 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_10 = 2

			if var_285_9 <= arg_282_1.time_ and arg_282_1.time_ < var_285_9 + var_285_10 then
				local var_285_11 = Color.New(0, 0, 0)

				var_285_11.a = Mathf.Lerp(1, 0, (arg_282_1.time_ - var_285_9) / var_285_10)
				arg_282_1.mask_.color = var_285_11
			end

			if arg_282_1.time_ >= var_285_9 + var_285_10 and arg_282_1.time_ < var_285_9 + var_285_10 + arg_285_0 then
				local var_285_12 = Color.New(0, 0, 0)

				arg_282_1.mask_.enabled = false
				var_285_12.a = 0
				arg_282_1.mask_.color = var_285_12
			end

			local var_285_13 = "1037ui_story"

			if arg_282_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_285_14 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_282_1.stage_.transform)

				var_285_14.name = var_285_13
				var_285_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.actors_[var_285_13] = var_285_14

				local var_285_15 = var_285_14:GetComponentInChildren(typeof(CharacterEffect))

				var_285_15.enabled = true

				local var_285_16 = GameObjectTools.GetOrAddComponent(var_285_14, typeof(DynamicBoneHelper))

				if var_285_16 then
					var_285_16:EnableDynamicBone(false)
				end

				arg_282_1:ShowWeapon(var_285_15.transform, false)

				arg_282_1.var_[var_285_13 .. "Animator"] = var_285_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_282_1.var_[var_285_13 .. "Animator"].applyRootMotion = true
				arg_282_1.var_[var_285_13 .. "LipSync"] = var_285_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_285_17 = arg_282_1.actors_["1037ui_story"].transform

			if 3.8 < arg_282_1.time_ and arg_282_1.time_ <= 3.8 + arg_285_0 then
				arg_282_1.var_.moveOldPos1037ui_story = var_285_17.localPosition
			end

			local var_285_18 = 0.001

			if 3.8 <= arg_282_1.time_ and arg_282_1.time_ < 3.8 + var_285_18 then
				var_285_17.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_282_1.time_ - 3.8) / var_285_18)
				var_285_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_17.position).x, (manager.ui.mainCamera.transform.position - var_285_17.position).y, (manager.ui.mainCamera.transform.position - var_285_17.position).z)
				var_285_17.localEulerAngles.z = 0
				var_285_17.localEulerAngles.x = 0
				var_285_17.localEulerAngles = var_285_17.localEulerAngles
			end

			if arg_282_1.time_ >= 3.8 + var_285_18 and arg_282_1.time_ < 3.8 + var_285_18 + arg_285_0 then
				var_285_17.localPosition = Vector3.New(0, -1.09, -5.81)
				var_285_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_17.position).x, (manager.ui.mainCamera.transform.position - var_285_17.position).y, (manager.ui.mainCamera.transform.position - var_285_17.position).z)
				var_285_17.localEulerAngles.z = 0
				var_285_17.localEulerAngles.x = 0
				var_285_17.localEulerAngles = var_285_17.localEulerAngles
			end

			local var_285_19 = arg_282_1.actors_["1037ui_story"]

			if 3.8 < arg_282_1.time_ and arg_282_1.time_ <= 3.8 + arg_285_0 and not isNil(var_285_19) and arg_282_1.var_.characterEffect1037ui_story == nil then
				arg_282_1.var_.characterEffect1037ui_story = var_285_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_20 = 0.200000002980232

			if 3.8 <= arg_282_1.time_ and arg_282_1.time_ < 3.8 + var_285_20 and not isNil(var_285_19) then
				if arg_282_1.var_.characterEffect1037ui_story and not isNil(var_285_19) then
					arg_282_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 3.8 + var_285_20 and arg_282_1.time_ < 3.8 + var_285_20 + arg_285_0 and not isNil(var_285_19) and arg_282_1.var_.characterEffect1037ui_story then
				arg_282_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 3.8 < arg_282_1.time_ and arg_282_1.time_ <= 3.8 + arg_285_0 then
				arg_282_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 3.8 < arg_282_1.time_ and arg_282_1.time_ <= 3.8 + arg_285_0 then
				arg_282_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.233333333333333 < arg_282_1.time_ and arg_282_1.time_ <= 0.233333333333333 + arg_285_0 then
				arg_282_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1.6 < arg_282_1.time_ and arg_282_1.time_ <= 1.6 + arg_285_0 then
				arg_282_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_285_24 = 3.8

			arg_282_1.isInRecall_ = true

			if var_285_24 < arg_282_1.time_ and arg_282_1.time_ <= var_285_24 + arg_285_0 then
				arg_282_1.screenFilterGo_:SetActive(true)

				arg_282_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_282_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_282_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_285_2, iter_285_3 in pairs(arg_282_1.actors_) do
					for iter_285_4, iter_285_5 in ipairs((iter_285_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_285_5.color = iter_285_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_285_25 = 0.2

			if var_285_24 <= arg_282_1.time_ and arg_282_1.time_ < var_285_24 + var_285_25 then
				arg_282_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_282_1.time_ - var_285_24) / var_285_25)
			end

			if arg_282_1.time_ >= var_285_24 + var_285_25 and arg_282_1.time_ < var_285_24 + var_285_25 + arg_285_0 then
				arg_282_1.screenFilterEffect_.weight = 1
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_26 = 4
			local var_285_27 = 0.6

			if 4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_26 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_28 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_28:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_29 = arg_282_1:GetWordFromCfg(1108504070)
				local var_285_30 = arg_282_1:FormatText(var_285_29.content)

				arg_282_1.text_.text = var_285_30

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_32 = 24 <= 0 and var_285_27 or var_285_27 * (utf8.len(var_285_30) / 24)

				if (24 <= 0 and var_285_27 or var_285_27 * (utf8.len(var_285_30) / 24)) > 0 and var_285_27 < var_285_32 then
					arg_282_1.talkMaxDuration = var_285_32
					var_285_26 = var_285_26 + 0.3

					if var_285_32 + var_285_26 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_32 + var_285_26
					end
				end

				arg_282_1.text_.text = var_285_30
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb") ~= 0 then
					local var_285_33 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb") / 1000

					if var_285_33 + var_285_26 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_33 + var_285_26
					end

					if var_285_29.prefab_name ~= "" and arg_282_1.actors_[var_285_29.prefab_name] ~= nil then
						local var_285_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_29.prefab_name].transform, "story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb")

						arg_282_1:RecordAudio("1108504070", var_285_34)
						arg_282_1:RecordAudio("1108504070", var_285_34)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_35 = var_285_26 + 0.3
			local var_285_36 = math.max(var_285_27, arg_282_1.talkMaxDuration)

			if var_285_26 + 0.3 <= arg_282_1.time_ and arg_282_1.time_ < var_285_35 + var_285_36 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_35) / var_285_36

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_35 + var_285_36 and arg_282_1.time_ < var_285_35 + var_285_36 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "shikoudixinlian1",
				duration = 0.1,
				className = "StoryTextGroupNode",
				startTime = 1.9,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1108504071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1108504071
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1108504072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1037ui_story"]) and arg_288_1.var_.characterEffect1037ui_story == nil then
				arg_288_1.var_.characterEffect1037ui_story = arg_288_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1037ui_story"]) then
				if arg_288_1.var_.characterEffect1037ui_story and not isNil(arg_288_1.actors_["1037ui_story"]) then
					arg_288_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1037ui_story"]) and arg_288_1.var_.characterEffect1037ui_story then
				arg_288_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_291_1 = 0
			local var_291_2 = 0.625

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
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

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(1108504071).content)

				arg_288_1.text_.text = var_291_3

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 25 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 25)

				if (25 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 25)) > 0 and var_291_2 < var_291_5 then
					arg_288_1.talkMaxDuration = var_291_5

					if var_291_5 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + var_291_1
					end
				end

				arg_288_1.text_.text = var_291_3
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_6 = math.max(var_291_2, arg_288_1.talkMaxDuration)

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_6 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_1) / var_291_6

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_1 + var_291_6 and arg_288_1.time_ < var_291_1 + var_291_6 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1108504072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1108504072
		arg_292_1.duration_ = 3.8

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1108504073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1085ui_story = arg_292_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_295_0 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 then
				arg_292_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_292_1.time_ - 0) / var_295_0)
				arg_292_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1085ui_story"].transform.position).z)
				arg_292_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1085ui_story"].transform.localEulerAngles = arg_292_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 then
				arg_292_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_292_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1085ui_story"].transform.position).z)
				arg_292_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1085ui_story"].transform.localEulerAngles = arg_292_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_295_1 = arg_292_1.actors_["1085ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1085ui_story == nil then
				arg_292_1.var_.characterEffect1085ui_story = var_295_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_2 and not isNil(var_295_1) then
				if arg_292_1.var_.characterEffect1085ui_story and not isNil(var_295_1) then
					arg_292_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_2 and arg_292_1.time_ < 0 + var_295_2 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1085ui_story then
				arg_292_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_295_4 = arg_292_1.actors_["1037ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1037ui_story = var_295_4.localPosition
			end

			local var_295_5 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_5 then
				var_295_4.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_292_1.time_ - 0) / var_295_5)
				var_295_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_4.position).x, (manager.ui.mainCamera.transform.position - var_295_4.position).y, (manager.ui.mainCamera.transform.position - var_295_4.position).z)
				var_295_4.localEulerAngles.z = 0
				var_295_4.localEulerAngles.x = 0
				var_295_4.localEulerAngles = var_295_4.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_5 and arg_292_1.time_ < 0 + var_295_5 + arg_295_0 then
				var_295_4.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				var_295_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_4.position).x, (manager.ui.mainCamera.transform.position - var_295_4.position).y, (manager.ui.mainCamera.transform.position - var_295_4.position).z)
				var_295_4.localEulerAngles.z = 0
				var_295_4.localEulerAngles.x = 0
				var_295_4.localEulerAngles = var_295_4.localEulerAngles
			end

			local var_295_6 = 0
			local var_295_7 = 0.15

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_8 = arg_292_1:GetWordFromCfg(1108504072)
				local var_295_9 = arg_292_1:FormatText(var_295_8.content)

				arg_292_1.text_.text = var_295_9

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 6 <= 0 and var_295_7 or var_295_7 * (utf8.len(var_295_9) / 6)

				if (6 <= 0 and var_295_7 or var_295_7 * (utf8.len(var_295_9) / 6)) > 0 and var_295_7 < var_295_11 then
					arg_292_1.talkMaxDuration = var_295_11

					if var_295_11 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_11 + var_295_6
					end
				end

				arg_292_1.text_.text = var_295_9
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb") ~= 0 then
					local var_295_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb") / 1000

					if var_295_12 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_12 + var_295_6
					end

					if var_295_8.prefab_name ~= "" and arg_292_1.actors_[var_295_8.prefab_name] ~= nil then
						local var_295_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_8.prefab_name].transform, "story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb")

						arg_292_1:RecordAudio("1108504072", var_295_13)
						arg_292_1:RecordAudio("1108504072", var_295_13)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_7, arg_292_1.talkMaxDuration)

			if var_295_6 <= arg_292_1.time_ and arg_292_1.time_ < var_295_6 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_6) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_6 + var_295_14 and arg_292_1.time_ < var_295_6 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play1108504073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1108504073
		arg_296_1.duration_ = 8.9

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1108504074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1037ui_story = arg_296_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1037ui_story"].transform.position).z)
				arg_296_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1037ui_story"].transform.localEulerAngles = arg_296_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_296_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1037ui_story"].transform.position).z)
				arg_296_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1037ui_story"].transform.localEulerAngles = arg_296_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1037ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1037ui_story == nil then
				arg_296_1.var_.characterEffect1037ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect1037ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1037ui_story then
				arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_299_4 = arg_296_1.actors_["1085ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_4) and arg_296_1.var_.characterEffect1085ui_story == nil then
				arg_296_1.var_.characterEffect1085ui_story = var_299_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_5 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_5 and not isNil(var_299_4) then
				if arg_296_1.var_.characterEffect1085ui_story and not isNil(var_299_4) then
					arg_296_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_5)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_5 and arg_296_1.time_ < 0 + var_299_5 + arg_299_0 and not isNil(var_299_4) and arg_296_1.var_.characterEffect1085ui_story then
				arg_296_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_299_6 = 0
			local var_299_7 = 0.9

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_8 = arg_296_1:GetWordFromCfg(1108504073)
				local var_299_9 = arg_296_1:FormatText(var_299_8.content)

				arg_296_1.text_.text = var_299_9

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 36 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_9) / 36)

				if (36 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_9) / 36)) > 0 and var_299_7 < var_299_11 then
					arg_296_1.talkMaxDuration = var_299_11

					if var_299_11 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_9
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb") ~= 0 then
					local var_299_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb") / 1000

					if var_299_12 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_12 + var_299_6
					end

					if var_299_8.prefab_name ~= "" and arg_296_1.actors_[var_299_8.prefab_name] ~= nil then
						local var_299_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_8.prefab_name].transform, "story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb")

						arg_296_1:RecordAudio("1108504073", var_299_13)
						arg_296_1:RecordAudio("1108504073", var_299_13)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_14 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_14 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_14

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_14 and arg_296_1.time_ < var_299_6 + var_299_14 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play1108504074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1108504074
		arg_300_1.duration_ = 2.7

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1108504075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1085ui_story = arg_300_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1085ui_story"].transform.position).z)
				arg_300_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1085ui_story"].transform.localEulerAngles = arg_300_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_300_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1085ui_story"].transform.position).z)
				arg_300_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1085ui_story"].transform.localEulerAngles = arg_300_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_303_1 = arg_300_1.actors_["1085ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect1085ui_story == nil then
				arg_300_1.var_.characterEffect1085ui_story = var_303_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 and not isNil(var_303_1) then
				if arg_300_1.var_.characterEffect1085ui_story and not isNil(var_303_1) then
					arg_300_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect1085ui_story then
				arg_300_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_303_4 = arg_300_1.actors_["1037ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_4) and arg_300_1.var_.characterEffect1037ui_story == nil then
				arg_300_1.var_.characterEffect1037ui_story = var_303_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_5 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_5 and not isNil(var_303_4) then
				if arg_300_1.var_.characterEffect1037ui_story and not isNil(var_303_4) then
					arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_5)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_5 and arg_300_1.time_ < 0 + var_303_5 + arg_303_0 and not isNil(var_303_4) and arg_300_1.var_.characterEffect1037ui_story then
				arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_303_6 = 0
			local var_303_7 = 0.15

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(1108504074)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 6 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 6)

				if (6 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 6)) > 0 and var_303_7 < var_303_11 then
					arg_300_1.talkMaxDuration = var_303_11

					if var_303_11 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb") ~= 0 then
					local var_303_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb") / 1000

					if var_303_12 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_6
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb")

						arg_300_1:RecordAudio("1108504074", var_303_13)
						arg_300_1:RecordAudio("1108504074", var_303_13)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1108504075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1108504075
		arg_304_1.duration_ = 1.37

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1108504076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.1

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(1108504075)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 4 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 4)

				if (4 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 4)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb")

						arg_304_1:RecordAudio("1108504075", var_307_6)
						arg_304_1:RecordAudio("1108504075", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1108504076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1108504076
		arg_308_1.duration_ = 10.47

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1108504077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 2 < arg_308_1.time_ and arg_308_1.time_ <= 2 + arg_311_0 then
				local var_311_0 = arg_308_1.bgs_.ST20

				arg_308_1.bgs_.ST20.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_311_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_311_1 = var_311_0:GetComponent("SpriteRenderer")

				if var_311_1 and var_311_1.sprite then
					local var_311_2 = 2 * (var_311_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_311_0.transform.localScale = Vector3.New(var_311_2 / var_311_1.sprite.bounds.size.y < var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x and var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x or var_311_2 / var_311_1.sprite.bounds.size.y, var_311_2 / var_311_1.sprite.bounds.size.y < var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x and var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x or var_311_2 / var_311_1.sprite.bounds.size.y, 0)
				end

				for iter_311_0, iter_311_1 in pairs(arg_308_1.bgs_) do
					if iter_311_0 ~= "ST20" then
						iter_311_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_311_3 = 4

			if 4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_3 + arg_311_0 then
				arg_308_1.allBtn_.enabled = false
			end

			if arg_308_1.time_ >= var_311_3 + 0.3 and arg_308_1.time_ < var_311_3 + 0.3 + arg_311_0 then
				arg_308_1.allBtn_.enabled = true
			end

			local var_311_4 = 0

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_5 = 2

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_5 then
				local var_311_6 = Color.New(0, 0, 0)

				var_311_6.a = Mathf.Lerp(0, 1, (arg_308_1.time_ - var_311_4) / var_311_5)
				arg_308_1.mask_.color = var_311_6
			end

			if arg_308_1.time_ >= var_311_4 + var_311_5 and arg_308_1.time_ < var_311_4 + var_311_5 + arg_311_0 then
				local var_311_7 = Color.New(0, 0, 0)

				var_311_7.a = 1
				arg_308_1.mask_.color = var_311_7
			end

			local var_311_8 = 2

			if 2 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_9 = 2

			if var_311_8 <= arg_308_1.time_ and arg_308_1.time_ < var_311_8 + var_311_9 then
				local var_311_10 = Color.New(0, 0, 0)

				var_311_10.a = Mathf.Lerp(1, 0, (arg_308_1.time_ - var_311_8) / var_311_9)
				arg_308_1.mask_.color = var_311_10
			end

			if arg_308_1.time_ >= var_311_8 + var_311_9 and arg_308_1.time_ < var_311_8 + var_311_9 + arg_311_0 then
				local var_311_11 = Color.New(0, 0, 0)

				arg_308_1.mask_.enabled = false
				var_311_11.a = 0
				arg_308_1.mask_.color = var_311_11
			end

			local var_311_12 = arg_308_1.actors_["1037ui_story"].transform

			if 1.96599999815226 < arg_308_1.time_ and arg_308_1.time_ <= 1.96599999815226 + arg_311_0 then
				arg_308_1.var_.moveOldPos1037ui_story = var_311_12.localPosition
			end

			local var_311_13 = 0.001

			if 1.96599999815226 <= arg_308_1.time_ and arg_308_1.time_ < 1.96599999815226 + var_311_13 then
				var_311_12.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 1.96599999815226) / var_311_13)
				var_311_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_12.position).x, (manager.ui.mainCamera.transform.position - var_311_12.position).y, (manager.ui.mainCamera.transform.position - var_311_12.position).z)
				var_311_12.localEulerAngles.z = 0
				var_311_12.localEulerAngles.x = 0
				var_311_12.localEulerAngles = var_311_12.localEulerAngles
			end

			if arg_308_1.time_ >= 1.96599999815226 + var_311_13 and arg_308_1.time_ < 1.96599999815226 + var_311_13 + arg_311_0 then
				var_311_12.localPosition = Vector3.New(0, 100, 0)
				var_311_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_12.position).x, (manager.ui.mainCamera.transform.position - var_311_12.position).y, (manager.ui.mainCamera.transform.position - var_311_12.position).z)
				var_311_12.localEulerAngles.z = 0
				var_311_12.localEulerAngles.x = 0
				var_311_12.localEulerAngles = var_311_12.localEulerAngles
			end

			local var_311_14 = arg_308_1.actors_["1037ui_story"]

			if 3.8 < arg_308_1.time_ and arg_308_1.time_ <= 3.8 + arg_311_0 and not isNil(var_311_14) and arg_308_1.var_.characterEffect1037ui_story == nil then
				arg_308_1.var_.characterEffect1037ui_story = var_311_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_15 = 0.200000002980232

			if 3.8 <= arg_308_1.time_ and arg_308_1.time_ < 3.8 + var_311_15 and not isNil(var_311_14) then
				if arg_308_1.var_.characterEffect1037ui_story and not isNil(var_311_14) then
					arg_308_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 3.8 + var_311_15 and arg_308_1.time_ < 3.8 + var_311_15 + arg_311_0 and not isNil(var_311_14) and arg_308_1.var_.characterEffect1037ui_story then
				arg_308_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_311_17 = arg_308_1.actors_["1085ui_story"]

			if 1.96599999815226 < arg_308_1.time_ and arg_308_1.time_ <= 1.96599999815226 + arg_311_0 and not isNil(var_311_17) and arg_308_1.var_.characterEffect1085ui_story == nil then
				arg_308_1.var_.characterEffect1085ui_story = var_311_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_18 = 0.034000001847744

			if 1.96599999815226 <= arg_308_1.time_ and arg_308_1.time_ < 1.96599999815226 + var_311_18 and not isNil(var_311_17) then
				if arg_308_1.var_.characterEffect1085ui_story and not isNil(var_311_17) then
					arg_308_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 1.96599999815226) / var_311_18)
				end
			end

			if arg_308_1.time_ >= 1.96599999815226 + var_311_18 and arg_308_1.time_ < 1.96599999815226 + var_311_18 + arg_311_0 and not isNil(var_311_17) and arg_308_1.var_.characterEffect1085ui_story then
				arg_308_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_311_19 = arg_308_1.actors_["1037ui_story"].transform

			if 3.8 < arg_308_1.time_ and arg_308_1.time_ <= 3.8 + arg_311_0 then
				arg_308_1.var_.moveOldPos1037ui_story = var_311_19.localPosition
			end

			local var_311_20 = 0.001

			if 3.8 <= arg_308_1.time_ and arg_308_1.time_ < 3.8 + var_311_20 then
				var_311_19.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_308_1.time_ - 3.8) / var_311_20)
				var_311_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_19.position).x, (manager.ui.mainCamera.transform.position - var_311_19.position).y, (manager.ui.mainCamera.transform.position - var_311_19.position).z)
				var_311_19.localEulerAngles.z = 0
				var_311_19.localEulerAngles.x = 0
				var_311_19.localEulerAngles = var_311_19.localEulerAngles
			end

			if arg_308_1.time_ >= 3.8 + var_311_20 and arg_308_1.time_ < 3.8 + var_311_20 + arg_311_0 then
				var_311_19.localPosition = Vector3.New(0, -1.09, -5.81)
				var_311_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_19.position).x, (manager.ui.mainCamera.transform.position - var_311_19.position).y, (manager.ui.mainCamera.transform.position - var_311_19.position).z)
				var_311_19.localEulerAngles.z = 0
				var_311_19.localEulerAngles.x = 0
				var_311_19.localEulerAngles = var_311_19.localEulerAngles
			end

			if 3.8 < arg_308_1.time_ and arg_308_1.time_ <= 3.8 + arg_311_0 then
				arg_308_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 3.8 < arg_308_1.time_ and arg_308_1.time_ <= 3.8 + arg_311_0 then
				arg_308_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_311_21 = arg_308_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_308_1.time_ and arg_308_1.time_ <= 1.96599999815226 + arg_311_0 then
				arg_308_1.var_.moveOldPos1085ui_story = var_311_21.localPosition
			end

			local var_311_22 = 0.001

			if 1.96599999815226 <= arg_308_1.time_ and arg_308_1.time_ < 1.96599999815226 + var_311_22 then
				var_311_21.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 1.96599999815226) / var_311_22)
				var_311_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_21.position).x, (manager.ui.mainCamera.transform.position - var_311_21.position).y, (manager.ui.mainCamera.transform.position - var_311_21.position).z)
				var_311_21.localEulerAngles.z = 0
				var_311_21.localEulerAngles.x = 0
				var_311_21.localEulerAngles = var_311_21.localEulerAngles
			end

			if arg_308_1.time_ >= 1.96599999815226 + var_311_22 and arg_308_1.time_ < 1.96599999815226 + var_311_22 + arg_311_0 then
				var_311_21.localPosition = Vector3.New(0, 100, 0)
				var_311_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_21.position).x, (manager.ui.mainCamera.transform.position - var_311_21.position).y, (manager.ui.mainCamera.transform.position - var_311_21.position).z)
				var_311_21.localEulerAngles.z = 0
				var_311_21.localEulerAngles.x = 0
				var_311_21.localEulerAngles = var_311_21.localEulerAngles
			end

			if arg_308_1.frameCnt_ <= 1 then
				arg_308_1.dialog_:SetActive(false)
			end

			local var_311_23 = 4
			local var_311_24 = 0.7

			if 4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_23 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0

				arg_308_1.dialog_:SetActive(true)

				arg_308_1.dialogCg_.alpha = 0

				local var_311_25 = LeanTween.value(arg_308_1.dialog_, 0, 1, 0.3)

				var_311_25:setOnUpdate(LuaHelper.FloatAction(function(arg_312_0)
					arg_308_1.dialogCg_.alpha = arg_312_0
				end))
				var_311_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_308_1.dialog_)
					var_311_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_308_1.duration_ = arg_308_1.duration_ + 0.3

				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_26 = arg_308_1:GetWordFromCfg(1108504076)
				local var_311_27 = arg_308_1:FormatText(var_311_26.content)

				arg_308_1.text_.text = var_311_27

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_29 = 28 <= 0 and var_311_24 or var_311_24 * (utf8.len(var_311_27) / 28)

				if (28 <= 0 and var_311_24 or var_311_24 * (utf8.len(var_311_27) / 28)) > 0 and var_311_24 < var_311_29 then
					arg_308_1.talkMaxDuration = var_311_29
					var_311_23 = var_311_23 + 0.3

					if var_311_29 + var_311_23 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_29 + var_311_23
					end
				end

				arg_308_1.text_.text = var_311_27
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb") ~= 0 then
					local var_311_30 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb") / 1000

					if var_311_30 + var_311_23 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_30 + var_311_23
					end

					if var_311_26.prefab_name ~= "" and arg_308_1.actors_[var_311_26.prefab_name] ~= nil then
						local var_311_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_26.prefab_name].transform, "story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb")

						arg_308_1:RecordAudio("1108504076", var_311_31)
						arg_308_1:RecordAudio("1108504076", var_311_31)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_32 = var_311_23 + 0.3
			local var_311_33 = math.max(var_311_24, arg_308_1.talkMaxDuration)

			if var_311_23 + 0.3 <= arg_308_1.time_ and arg_308_1.time_ < var_311_32 + var_311_33 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_32) / var_311_33

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_32 + var_311_33 and arg_308_1.time_ < var_311_32 + var_311_33 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play1108504077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1108504077
		arg_314_1.duration_ = 8.97

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1108504078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_317_0 = 0
			local var_317_1 = 0.675

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(1108504077)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 27 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 27)

				if (27 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 27)) > 0 and var_317_1 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb") ~= 0 then
					local var_317_6 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb") / 1000

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end

					if var_317_2.prefab_name ~= "" and arg_314_1.actors_[var_317_2.prefab_name] ~= nil then
						local var_317_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_2.prefab_name].transform, "story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb")

						arg_314_1:RecordAudio("1108504077", var_317_7)
						arg_314_1:RecordAudio("1108504077", var_317_7)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_8 and arg_314_1.time_ < var_317_0 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1108504078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1108504078
		arg_318_1.duration_ = 8.97

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1108504079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1037ui_story = arg_318_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1037ui_story"].transform.position).z)
				arg_318_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1037ui_story"].transform.localEulerAngles = arg_318_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_318_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1037ui_story"].transform.position).z)
				arg_318_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1037ui_story"].transform.localEulerAngles = arg_318_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_2")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_321_1 = 0
			local var_321_2 = 1.025

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:GetWordFromCfg(1108504078)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_6 = 41 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_4) / 41)

				if (41 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_4) / 41)) > 0 and var_321_2 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb") ~= 0 then
					local var_321_7 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb") / 1000

					if var_321_7 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_1
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb")

						arg_318_1:RecordAudio("1108504078", var_321_8)
						arg_318_1:RecordAudio("1108504078", var_321_8)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_9 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_9 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_9

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_9 and arg_318_1.time_ < var_321_1 + var_321_9 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play1108504079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1108504079
		arg_322_1.duration_ = 10.2

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1108504080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_325_0 = 0
			local var_325_1 = 1.05

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_2 = arg_322_1:GetWordFromCfg(1108504079)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 42 <= 0 and var_325_1 or var_325_1 * (utf8.len(var_325_3) / 42)

				if (42 <= 0 and var_325_1 or var_325_1 * (utf8.len(var_325_3) / 42)) > 0 and var_325_1 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb") ~= 0 then
					local var_325_6 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb") / 1000

					if var_325_6 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_0
					end

					if var_325_2.prefab_name ~= "" and arg_322_1.actors_[var_325_2.prefab_name] ~= nil then
						local var_325_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_2.prefab_name].transform, "story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb")

						arg_322_1:RecordAudio("1108504079", var_325_7)
						arg_322_1:RecordAudio("1108504079", var_325_7)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_8 and arg_322_1.time_ < var_325_0 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1108504080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1108504080
		arg_326_1.duration_ = 8.17

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1108504081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if arg_326_1.bgs_.ST07a == nil then
				local var_329_0 = Object.Instantiate(arg_326_1.paintGo_)

				var_329_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07a")
				var_329_0.name = "ST07a"
				var_329_0.transform.parent = arg_326_1.stage_.transform
				var_329_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.bgs_.ST07a = var_329_0
			end

			if 2 < arg_326_1.time_ and arg_326_1.time_ <= 2 + arg_329_0 then
				local var_329_1 = arg_326_1.bgs_.ST07a

				arg_326_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_329_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_329_2 = var_329_1:GetComponent("SpriteRenderer")

				if var_329_2 and var_329_2.sprite then
					local var_329_3 = 2 * (var_329_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_329_1.transform.localScale = Vector3.New(var_329_3 / var_329_2.sprite.bounds.size.y < var_329_3 * manager.ui.mainCameraCom_.aspect / var_329_2.sprite.bounds.size.x and var_329_3 * manager.ui.mainCameraCom_.aspect / var_329_2.sprite.bounds.size.x or var_329_3 / var_329_2.sprite.bounds.size.y, var_329_3 / var_329_2.sprite.bounds.size.y < var_329_3 * manager.ui.mainCameraCom_.aspect / var_329_2.sprite.bounds.size.x and var_329_3 * manager.ui.mainCameraCom_.aspect / var_329_2.sprite.bounds.size.x or var_329_3 / var_329_2.sprite.bounds.size.y, 0)
				end

				for iter_329_0, iter_329_1 in pairs(arg_326_1.bgs_) do
					if iter_329_0 ~= "ST07a" then
						iter_329_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_329_4 = 4

			if 4 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				arg_326_1.allBtn_.enabled = false
			end

			if arg_326_1.time_ >= var_329_4 + 0.3 and arg_326_1.time_ < var_329_4 + 0.3 + arg_329_0 then
				arg_326_1.allBtn_.enabled = true
			end

			local var_329_5 = 0

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_6 = 2

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_6 then
				local var_329_7 = Color.New(0, 0, 0)

				var_329_7.a = Mathf.Lerp(0, 1, (arg_326_1.time_ - var_329_5) / var_329_6)
				arg_326_1.mask_.color = var_329_7
			end

			if arg_326_1.time_ >= var_329_5 + var_329_6 and arg_326_1.time_ < var_329_5 + var_329_6 + arg_329_0 then
				local var_329_8 = Color.New(0, 0, 0)

				var_329_8.a = 1
				arg_326_1.mask_.color = var_329_8
			end

			local var_329_9 = 2

			if 2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_9 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_10 = 2

			if var_329_9 <= arg_326_1.time_ and arg_326_1.time_ < var_329_9 + var_329_10 then
				local var_329_11 = Color.New(0, 0, 0)

				var_329_11.a = Mathf.Lerp(1, 0, (arg_326_1.time_ - var_329_9) / var_329_10)
				arg_326_1.mask_.color = var_329_11
			end

			if arg_326_1.time_ >= var_329_9 + var_329_10 and arg_326_1.time_ < var_329_9 + var_329_10 + arg_329_0 then
				local var_329_12 = Color.New(0, 0, 0)

				arg_326_1.mask_.enabled = false
				var_329_12.a = 0
				arg_326_1.mask_.color = var_329_12
			end

			local var_329_13 = arg_326_1.actors_["1085ui_story"].transform

			if 3.79999999701977 < arg_326_1.time_ and arg_326_1.time_ <= 3.79999999701977 + arg_329_0 then
				arg_326_1.var_.moveOldPos1085ui_story = var_329_13.localPosition
			end

			local var_329_14 = 0.001

			if 3.79999999701977 <= arg_326_1.time_ and arg_326_1.time_ < 3.79999999701977 + var_329_14 then
				var_329_13.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_326_1.time_ - 3.79999999701977) / var_329_14)
				var_329_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_13.position).x, (manager.ui.mainCamera.transform.position - var_329_13.position).y, (manager.ui.mainCamera.transform.position - var_329_13.position).z)
				var_329_13.localEulerAngles.z = 0
				var_329_13.localEulerAngles.x = 0
				var_329_13.localEulerAngles = var_329_13.localEulerAngles
			end

			if arg_326_1.time_ >= 3.79999999701977 + var_329_14 and arg_326_1.time_ < 3.79999999701977 + var_329_14 + arg_329_0 then
				var_329_13.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_329_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_13.position).x, (manager.ui.mainCamera.transform.position - var_329_13.position).y, (manager.ui.mainCamera.transform.position - var_329_13.position).z)
				var_329_13.localEulerAngles.z = 0
				var_329_13.localEulerAngles.x = 0
				var_329_13.localEulerAngles = var_329_13.localEulerAngles
			end

			local var_329_15 = arg_326_1.actors_["1085ui_story"]

			if 3.79999999701977 < arg_326_1.time_ and arg_326_1.time_ <= 3.79999999701977 + arg_329_0 and not isNil(var_329_15) and arg_326_1.var_.characterEffect1085ui_story == nil then
				arg_326_1.var_.characterEffect1085ui_story = var_329_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_16 = 0.2

			if 3.79999999701977 <= arg_326_1.time_ and arg_326_1.time_ < 3.79999999701977 + var_329_16 and not isNil(var_329_15) then
				if arg_326_1.var_.characterEffect1085ui_story and not isNil(var_329_15) then
					arg_326_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 3.79999999701977 + var_329_16 and arg_326_1.time_ < 3.79999999701977 + var_329_16 + arg_329_0 and not isNil(var_329_15) and arg_326_1.var_.characterEffect1085ui_story then
				arg_326_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.79999999701977 < arg_326_1.time_ and arg_326_1.time_ <= 3.79999999701977 + arg_329_0 then
				arg_326_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_329_18 = arg_326_1.actors_["1037ui_story"].transform

			if 1.96599999815226 < arg_326_1.time_ and arg_326_1.time_ <= 1.96599999815226 + arg_329_0 then
				arg_326_1.var_.moveOldPos1037ui_story = var_329_18.localPosition
			end

			local var_329_19 = 0.001

			if 1.96599999815226 <= arg_326_1.time_ and arg_326_1.time_ < 1.96599999815226 + var_329_19 then
				var_329_18.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 1.96599999815226) / var_329_19)
				var_329_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_18.position).x, (manager.ui.mainCamera.transform.position - var_329_18.position).y, (manager.ui.mainCamera.transform.position - var_329_18.position).z)
				var_329_18.localEulerAngles.z = 0
				var_329_18.localEulerAngles.x = 0
				var_329_18.localEulerAngles = var_329_18.localEulerAngles
			end

			if arg_326_1.time_ >= 1.96599999815226 + var_329_19 and arg_326_1.time_ < 1.96599999815226 + var_329_19 + arg_329_0 then
				var_329_18.localPosition = Vector3.New(0, 100, 0)
				var_329_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_18.position).x, (manager.ui.mainCamera.transform.position - var_329_18.position).y, (manager.ui.mainCamera.transform.position - var_329_18.position).z)
				var_329_18.localEulerAngles.z = 0
				var_329_18.localEulerAngles.x = 0
				var_329_18.localEulerAngles = var_329_18.localEulerAngles
			end

			if 3.79999999701977 < arg_326_1.time_ and arg_326_1.time_ <= 3.79999999701977 + arg_329_0 then
				arg_326_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_329_20 = arg_326_1.actors_["1037ui_story"]

			if 1.98333333333333 < arg_326_1.time_ and arg_326_1.time_ <= 1.98333333333333 + arg_329_0 and not isNil(var_329_20) and arg_326_1.var_.characterEffect1037ui_story == nil then
				arg_326_1.var_.characterEffect1037ui_story = var_329_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_21 = 0.0166666666666666

			if 1.98333333333333 <= arg_326_1.time_ and arg_326_1.time_ < 1.98333333333333 + var_329_21 and not isNil(var_329_20) then
				if arg_326_1.var_.characterEffect1037ui_story and not isNil(var_329_20) then
					arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 1.98333333333333) / var_329_21)
				end
			end

			if arg_326_1.time_ >= 1.98333333333333 + var_329_21 and arg_326_1.time_ < 1.98333333333333 + var_329_21 + arg_329_0 and not isNil(var_329_20) and arg_326_1.var_.characterEffect1037ui_story then
				arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0.266666666666667 < arg_326_1.time_ and arg_326_1.time_ <= 0.266666666666667 + arg_329_0 then
				arg_326_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.56666666666667 < arg_326_1.time_ and arg_326_1.time_ <= 1.56666666666667 + arg_329_0 then
				arg_326_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_329_24 = arg_326_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_326_1.time_ and arg_326_1.time_ <= 1.96599999815226 + arg_329_0 then
				arg_326_1.var_.moveOldPos1085ui_story = var_329_24.localPosition
			end

			local var_329_25 = 0.001

			if 1.96599999815226 <= arg_326_1.time_ and arg_326_1.time_ < 1.96599999815226 + var_329_25 then
				var_329_24.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 1.96599999815226) / var_329_25)
				var_329_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_24.position).x, (manager.ui.mainCamera.transform.position - var_329_24.position).y, (manager.ui.mainCamera.transform.position - var_329_24.position).z)
				var_329_24.localEulerAngles.z = 0
				var_329_24.localEulerAngles.x = 0
				var_329_24.localEulerAngles = var_329_24.localEulerAngles
			end

			if arg_326_1.time_ >= 1.96599999815226 + var_329_25 and arg_326_1.time_ < 1.96599999815226 + var_329_25 + arg_329_0 then
				var_329_24.localPosition = Vector3.New(0, 100, 0)
				var_329_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_24.position).x, (manager.ui.mainCamera.transform.position - var_329_24.position).y, (manager.ui.mainCamera.transform.position - var_329_24.position).z)
				var_329_24.localEulerAngles.z = 0
				var_329_24.localEulerAngles.x = 0
				var_329_24.localEulerAngles = var_329_24.localEulerAngles
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_26 = 4
			local var_329_27 = 0.35

			if 4 < arg_326_1.time_ and arg_326_1.time_ <= var_329_26 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_28 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_28:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_29 = arg_326_1:GetWordFromCfg(1108504080)
				local var_329_30 = arg_326_1:FormatText(var_329_29.content)

				arg_326_1.text_.text = var_329_30

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_32 = 14 <= 0 and var_329_27 or var_329_27 * (utf8.len(var_329_30) / 14)

				if (14 <= 0 and var_329_27 or var_329_27 * (utf8.len(var_329_30) / 14)) > 0 and var_329_27 < var_329_32 then
					arg_326_1.talkMaxDuration = var_329_32
					var_329_26 = var_329_26 + 0.3

					if var_329_32 + var_329_26 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_32 + var_329_26
					end
				end

				arg_326_1.text_.text = var_329_30
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb") ~= 0 then
					local var_329_33 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb") / 1000

					if var_329_33 + var_329_26 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_33 + var_329_26
					end

					if var_329_29.prefab_name ~= "" and arg_326_1.actors_[var_329_29.prefab_name] ~= nil then
						local var_329_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_29.prefab_name].transform, "story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb")

						arg_326_1:RecordAudio("1108504080", var_329_34)
						arg_326_1:RecordAudio("1108504080", var_329_34)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_35 = var_329_26 + 0.3
			local var_329_36 = math.max(var_329_27, arg_326_1.talkMaxDuration)

			if var_329_26 + 0.3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_35 + var_329_36 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_35) / var_329_36

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_35 + var_329_36 and arg_326_1.time_ < var_329_35 + var_329_36 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play1108504081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1108504081
		arg_332_1.duration_ = 1.97

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1108504082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if arg_332_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_335_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_332_1.stage_.transform)

				var_335_0.name = "10066ui_story"
				var_335_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_332_1.actors_["10066ui_story"] = var_335_0

				local var_335_1 = var_335_0:GetComponentInChildren(typeof(CharacterEffect))

				var_335_1.enabled = true

				local var_335_2 = GameObjectTools.GetOrAddComponent(var_335_0, typeof(DynamicBoneHelper))

				if var_335_2 then
					var_335_2:EnableDynamicBone(false)
				end

				arg_332_1:ShowWeapon(var_335_1.transform, false)

				arg_332_1.var_["10066ui_story" .. "Animator"] = var_335_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_332_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_332_1.var_["10066ui_story" .. "LipSync"] = var_335_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_335_3 = arg_332_1.actors_["10066ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10066ui_story = var_335_3.localPosition
			end

			local var_335_4 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 then
				var_335_3.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_332_1.time_ - 0) / var_335_4)
				var_335_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_3.position).x, (manager.ui.mainCamera.transform.position - var_335_3.position).y, (manager.ui.mainCamera.transform.position - var_335_3.position).z)
				var_335_3.localEulerAngles.z = 0
				var_335_3.localEulerAngles.x = 0
				var_335_3.localEulerAngles = var_335_3.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 then
				var_335_3.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_335_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_3.position).x, (manager.ui.mainCamera.transform.position - var_335_3.position).y, (manager.ui.mainCamera.transform.position - var_335_3.position).z)
				var_335_3.localEulerAngles.z = 0
				var_335_3.localEulerAngles.x = 0
				var_335_3.localEulerAngles = var_335_3.localEulerAngles
			end

			local var_335_5 = arg_332_1.actors_["1037ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1037ui_story = var_335_5.localPosition
			end

			local var_335_6 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_6 then
				var_335_5.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_6)
				var_335_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_5.position).x, (manager.ui.mainCamera.transform.position - var_335_5.position).y, (manager.ui.mainCamera.transform.position - var_335_5.position).z)
				var_335_5.localEulerAngles.z = 0
				var_335_5.localEulerAngles.x = 0
				var_335_5.localEulerAngles = var_335_5.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_6 and arg_332_1.time_ < 0 + var_335_6 + arg_335_0 then
				var_335_5.localPosition = Vector3.New(0, 100, 0)
				var_335_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_5.position).x, (manager.ui.mainCamera.transform.position - var_335_5.position).y, (manager.ui.mainCamera.transform.position - var_335_5.position).z)
				var_335_5.localEulerAngles.z = 0
				var_335_5.localEulerAngles.x = 0
				var_335_5.localEulerAngles = var_335_5.localEulerAngles
			end

			local var_335_7 = arg_332_1.actors_["10066ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_7) and arg_332_1.var_.characterEffect10066ui_story == nil then
				arg_332_1.var_.characterEffect10066ui_story = var_335_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_8 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_8 and not isNil(var_335_7) then
				if arg_332_1.var_.characterEffect10066ui_story and not isNil(var_335_7) then
					arg_332_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_8 and arg_332_1.time_ < 0 + var_335_8 + arg_335_0 and not isNil(var_335_7) and arg_332_1.var_.characterEffect10066ui_story then
				arg_332_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_335_10 = arg_332_1.actors_["1085ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_10) and arg_332_1.var_.characterEffect1085ui_story == nil then
				arg_332_1.var_.characterEffect1085ui_story = var_335_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_11 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_11 and not isNil(var_335_10) then
				if arg_332_1.var_.characterEffect1085ui_story and not isNil(var_335_10) then
					arg_332_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_11)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_11 and arg_332_1.time_ < 0 + var_335_11 + arg_335_0 and not isNil(var_335_10) and arg_332_1.var_.characterEffect1085ui_story then
				arg_332_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_335_12 = 0
			local var_335_13 = 0.2

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_12 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_14 = arg_332_1:GetWordFromCfg(1108504081)
				local var_335_15 = arg_332_1:FormatText(var_335_14.content)

				arg_332_1.text_.text = var_335_15

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_17 = 8 <= 0 and var_335_13 or var_335_13 * (utf8.len(var_335_15) / 8)

				if (8 <= 0 and var_335_13 or var_335_13 * (utf8.len(var_335_15) / 8)) > 0 and var_335_13 < var_335_17 then
					arg_332_1.talkMaxDuration = var_335_17

					if var_335_17 + var_335_12 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_17 + var_335_12
					end
				end

				arg_332_1.text_.text = var_335_15
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb") ~= 0 then
					local var_335_18 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb") / 1000

					if var_335_18 + var_335_12 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_18 + var_335_12
					end

					if var_335_14.prefab_name ~= "" and arg_332_1.actors_[var_335_14.prefab_name] ~= nil then
						local var_335_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_14.prefab_name].transform, "story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb")

						arg_332_1:RecordAudio("1108504081", var_335_19)
						arg_332_1:RecordAudio("1108504081", var_335_19)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_20 = math.max(var_335_13, arg_332_1.talkMaxDuration)

			if var_335_12 <= arg_332_1.time_ and arg_332_1.time_ < var_335_12 + var_335_20 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_12) / var_335_20

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_12 + var_335_20 and arg_332_1.time_ < var_335_12 + var_335_20 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play1108504082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1108504082
		arg_336_1.duration_ = 6.8

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1108504083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1085ui_story = arg_336_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1085ui_story"].transform.position).z)
				arg_336_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1085ui_story"].transform.localEulerAngles = arg_336_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_336_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1085ui_story"].transform.position).z)
				arg_336_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1085ui_story"].transform.localEulerAngles = arg_336_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_339_1 = arg_336_1.actors_["1085ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1085ui_story == nil then
				arg_336_1.var_.characterEffect1085ui_story = var_339_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_2 and not isNil(var_339_1) then
				if arg_336_1.var_.characterEffect1085ui_story and not isNil(var_339_1) then
					arg_336_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_2 and arg_336_1.time_ < 0 + var_339_2 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1085ui_story then
				arg_336_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_339_4 = arg_336_1.actors_["10066ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_4) and arg_336_1.var_.characterEffect10066ui_story == nil then
				arg_336_1.var_.characterEffect10066ui_story = var_339_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_5 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_5 and not isNil(var_339_4) then
				if arg_336_1.var_.characterEffect10066ui_story and not isNil(var_339_4) then
					arg_336_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_5)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_5 and arg_336_1.time_ < 0 + var_339_5 + arg_339_0 and not isNil(var_339_4) and arg_336_1.var_.characterEffect10066ui_story then
				arg_336_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_339_6 = 0
			local var_339_7 = 0.6

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_8 = arg_336_1:GetWordFromCfg(1108504082)
				local var_339_9 = arg_336_1:FormatText(var_339_8.content)

				arg_336_1.text_.text = var_339_9

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 24 <= 0 and var_339_7 or var_339_7 * (utf8.len(var_339_9) / 24)

				if (24 <= 0 and var_339_7 or var_339_7 * (utf8.len(var_339_9) / 24)) > 0 and var_339_7 < var_339_11 then
					arg_336_1.talkMaxDuration = var_339_11

					if var_339_11 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_11 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_9
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb") ~= 0 then
					local var_339_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb") / 1000

					if var_339_12 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_12 + var_339_6
					end

					if var_339_8.prefab_name ~= "" and arg_336_1.actors_[var_339_8.prefab_name] ~= nil then
						local var_339_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_8.prefab_name].transform, "story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb")

						arg_336_1:RecordAudio("1108504082", var_339_13)
						arg_336_1:RecordAudio("1108504082", var_339_13)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_14 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_14 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_14

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_14 and arg_336_1.time_ < var_339_6 + var_339_14 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play1108504083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1108504083
		arg_340_1.duration_ = 6

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1108504084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.525

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:GetWordFromCfg(1108504083)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 21 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 21)

				if (21 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 21)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb")

						arg_340_1:RecordAudio("1108504083", var_343_6)
						arg_340_1:RecordAudio("1108504083", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb")
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
	Play1108504084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1108504084
		arg_344_1.duration_ = 6.83

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1108504085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10066ui_story = arg_344_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_347_0 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 then
				arg_344_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_344_1.time_ - 0) / var_347_0)
				arg_344_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10066ui_story"].transform.position).z)
				arg_344_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["10066ui_story"].transform.localEulerAngles = arg_344_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 then
				arg_344_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_344_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10066ui_story"].transform.position).z)
				arg_344_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["10066ui_story"].transform.localEulerAngles = arg_344_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_347_1 = arg_344_1.actors_["10066ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect10066ui_story == nil then
				arg_344_1.var_.characterEffect10066ui_story = var_347_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_2 and not isNil(var_347_1) then
				if arg_344_1.var_.characterEffect10066ui_story and not isNil(var_347_1) then
					arg_344_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_2 and arg_344_1.time_ < 0 + var_347_2 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect10066ui_story then
				arg_344_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_347_4 = arg_344_1.actors_["1085ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1085ui_story == nil then
				arg_344_1.var_.characterEffect1085ui_story = var_347_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_5 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_5 and not isNil(var_347_4) then
				if arg_344_1.var_.characterEffect1085ui_story and not isNil(var_347_4) then
					arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_5)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_5 and arg_344_1.time_ < 0 + var_347_5 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1085ui_story then
				arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_347_6 = 0
			local var_347_7 = 0.825

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_8 = arg_344_1:GetWordFromCfg(1108504084)
				local var_347_9 = arg_344_1:FormatText(var_347_8.content)

				arg_344_1.text_.text = var_347_9

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 33 <= 0 and var_347_7 or var_347_7 * (utf8.len(var_347_9) / 33)

				if (33 <= 0 and var_347_7 or var_347_7 * (utf8.len(var_347_9) / 33)) > 0 and var_347_7 < var_347_11 then
					arg_344_1.talkMaxDuration = var_347_11

					if var_347_11 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_11 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_9
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb") ~= 0 then
					local var_347_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb") / 1000

					if var_347_12 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_12 + var_347_6
					end

					if var_347_8.prefab_name ~= "" and arg_344_1.actors_[var_347_8.prefab_name] ~= nil then
						local var_347_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_8.prefab_name].transform, "story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb")

						arg_344_1:RecordAudio("1108504084", var_347_13)
						arg_344_1:RecordAudio("1108504084", var_347_13)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_14 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_14 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_14

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_14 and arg_344_1.time_ < var_347_6 + var_347_14 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play1108504085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1108504085
		arg_348_1.duration_ = 7.27

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1108504086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_351_0 = 0
			local var_351_1 = 0.825

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_2 = arg_348_1:GetWordFromCfg(1108504085)
				local var_351_3 = arg_348_1:FormatText(var_351_2.content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 33 <= 0 and var_351_1 or var_351_1 * (utf8.len(var_351_3) / 33)

				if (33 <= 0 and var_351_1 or var_351_1 * (utf8.len(var_351_3) / 33)) > 0 and var_351_1 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb") ~= 0 then
					local var_351_6 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb") / 1000

					if var_351_6 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_0
					end

					if var_351_2.prefab_name ~= "" and arg_348_1.actors_[var_351_2.prefab_name] ~= nil then
						local var_351_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_2.prefab_name].transform, "story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb")

						arg_348_1:RecordAudio("1108504085", var_351_7)
						arg_348_1:RecordAudio("1108504085", var_351_7)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1108504086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1108504086
		arg_352_1.duration_ = 2

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1108504087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1085ui_story = arg_352_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_355_0 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 then
				arg_352_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_352_1.time_ - 0) / var_355_0)
				arg_352_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1085ui_story"].transform.position).z)
				arg_352_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1085ui_story"].transform.localEulerAngles = arg_352_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 then
				arg_352_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_352_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1085ui_story"].transform.position).z)
				arg_352_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1085ui_story"].transform.localEulerAngles = arg_352_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_355_1 = arg_352_1.actors_["1085ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1085ui_story == nil then
				arg_352_1.var_.characterEffect1085ui_story = var_355_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_2 and not isNil(var_355_1) then
				if arg_352_1.var_.characterEffect1085ui_story and not isNil(var_355_1) then
					arg_352_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_2 and arg_352_1.time_ < 0 + var_355_2 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1085ui_story then
				arg_352_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_355_4 = arg_352_1.actors_["10066ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_4) and arg_352_1.var_.characterEffect10066ui_story == nil then
				arg_352_1.var_.characterEffect10066ui_story = var_355_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_5 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_5 and not isNil(var_355_4) then
				if arg_352_1.var_.characterEffect10066ui_story and not isNil(var_355_4) then
					arg_352_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_352_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_5)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_5 and arg_352_1.time_ < 0 + var_355_5 + arg_355_0 and not isNil(var_355_4) and arg_352_1.var_.characterEffect10066ui_story then
				arg_352_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_352_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_355_6 = 0
			local var_355_7 = 0.075

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_8 = arg_352_1:GetWordFromCfg(1108504086)
				local var_355_9 = arg_352_1:FormatText(var_355_8.content)

				arg_352_1.text_.text = var_355_9

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 3 <= 0 and var_355_7 or var_355_7 * (utf8.len(var_355_9) / 3)

				if (3 <= 0 and var_355_7 or var_355_7 * (utf8.len(var_355_9) / 3)) > 0 and var_355_7 < var_355_11 then
					arg_352_1.talkMaxDuration = var_355_11

					if var_355_11 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_9
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb") ~= 0 then
					local var_355_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb") / 1000

					if var_355_12 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_6
					end

					if var_355_8.prefab_name ~= "" and arg_352_1.actors_[var_355_8.prefab_name] ~= nil then
						local var_355_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_8.prefab_name].transform, "story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb")

						arg_352_1:RecordAudio("1108504086", var_355_13)
						arg_352_1:RecordAudio("1108504086", var_355_13)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_14 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_14 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_14

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_14 and arg_352_1.time_ < var_355_6 + var_355_14 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play1108504087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1108504087
		arg_356_1.duration_ = 8.83

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1108504088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if arg_356_1.bgs_.ST07b == nil then
				local var_359_0 = Object.Instantiate(arg_356_1.paintGo_)

				var_359_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_359_0.name = "ST07b"
				var_359_0.transform.parent = arg_356_1.stage_.transform
				var_359_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_356_1.bgs_.ST07b = var_359_0
			end

			if 1.999999999999 < arg_356_1.time_ and arg_356_1.time_ <= 1.999999999999 + arg_359_0 then
				local var_359_1 = arg_356_1.bgs_.ST07b

				arg_356_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_359_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_359_2 = var_359_1:GetComponent("SpriteRenderer")

				if var_359_2 and var_359_2.sprite then
					local var_359_3 = 2 * (var_359_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_359_1.transform.localScale = Vector3.New(var_359_3 / var_359_2.sprite.bounds.size.y < var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x and var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x or var_359_3 / var_359_2.sprite.bounds.size.y, var_359_3 / var_359_2.sprite.bounds.size.y < var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x and var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x or var_359_3 / var_359_2.sprite.bounds.size.y, 0)
				end

				for iter_359_0, iter_359_1 in pairs(arg_356_1.bgs_) do
					if iter_359_0 ~= "ST07b" then
						iter_359_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_359_4 = 3.999999999999

			if 3.999999999999 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1.allBtn_.enabled = false
			end

			if arg_356_1.time_ >= var_359_4 + 0.3 and arg_356_1.time_ < var_359_4 + 0.3 + arg_359_0 then
				arg_356_1.allBtn_.enabled = true
			end

			local var_359_5 = 0

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_5 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_6 = 2

			if var_359_5 <= arg_356_1.time_ and arg_356_1.time_ < var_359_5 + var_359_6 then
				local var_359_7 = Color.New(0, 0, 0)

				var_359_7.a = Mathf.Lerp(0, 1, (arg_356_1.time_ - var_359_5) / var_359_6)
				arg_356_1.mask_.color = var_359_7
			end

			if arg_356_1.time_ >= var_359_5 + var_359_6 and arg_356_1.time_ < var_359_5 + var_359_6 + arg_359_0 then
				local var_359_8 = Color.New(0, 0, 0)

				var_359_8.a = 1
				arg_356_1.mask_.color = var_359_8
			end

			local var_359_9 = 2

			if 2 < arg_356_1.time_ and arg_356_1.time_ <= var_359_9 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_10 = 2

			if var_359_9 <= arg_356_1.time_ and arg_356_1.time_ < var_359_9 + var_359_10 then
				local var_359_11 = Color.New(0, 0, 0)

				var_359_11.a = Mathf.Lerp(1, 0, (arg_356_1.time_ - var_359_9) / var_359_10)
				arg_356_1.mask_.color = var_359_11
			end

			if arg_356_1.time_ >= var_359_9 + var_359_10 and arg_356_1.time_ < var_359_9 + var_359_10 + arg_359_0 then
				local var_359_12 = Color.New(0, 0, 0)

				arg_356_1.mask_.enabled = false
				var_359_12.a = 0
				arg_356_1.mask_.color = var_359_12
			end

			local var_359_13 = arg_356_1.actors_["10066ui_story"].transform

			if 3.8 < arg_356_1.time_ and arg_356_1.time_ <= 3.8 + arg_359_0 then
				arg_356_1.var_.moveOldPos10066ui_story = var_359_13.localPosition
			end

			local var_359_14 = 0.001

			if 3.8 <= arg_356_1.time_ and arg_356_1.time_ < 3.8 + var_359_14 then
				var_359_13.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_356_1.time_ - 3.8) / var_359_14)
				var_359_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_359_13.position).x, (manager.ui.mainCamera.transform.position - var_359_13.position).y, (manager.ui.mainCamera.transform.position - var_359_13.position).z)
				var_359_13.localEulerAngles.z = 0
				var_359_13.localEulerAngles.x = 0
				var_359_13.localEulerAngles = var_359_13.localEulerAngles
			end

			if arg_356_1.time_ >= 3.8 + var_359_14 and arg_356_1.time_ < 3.8 + var_359_14 + arg_359_0 then
				var_359_13.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_359_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_359_13.position).x, (manager.ui.mainCamera.transform.position - var_359_13.position).y, (manager.ui.mainCamera.transform.position - var_359_13.position).z)
				var_359_13.localEulerAngles.z = 0
				var_359_13.localEulerAngles.x = 0
				var_359_13.localEulerAngles = var_359_13.localEulerAngles
			end

			local var_359_15 = arg_356_1.actors_["10066ui_story"]

			if 3.8 < arg_356_1.time_ and arg_356_1.time_ <= 3.8 + arg_359_0 and not isNil(var_359_15) and arg_356_1.var_.characterEffect10066ui_story == nil then
				arg_356_1.var_.characterEffect10066ui_story = var_359_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_16 = 0.200000002980232

			if 3.8 <= arg_356_1.time_ and arg_356_1.time_ < 3.8 + var_359_16 and not isNil(var_359_15) then
				if arg_356_1.var_.characterEffect10066ui_story and not isNil(var_359_15) then
					arg_356_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 3.8 + var_359_16 and arg_356_1.time_ < 3.8 + var_359_16 + arg_359_0 and not isNil(var_359_15) and arg_356_1.var_.characterEffect10066ui_story then
				arg_356_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_359_18 = arg_356_1.actors_["1085ui_story"]

			if 1.79999999701977 < arg_356_1.time_ and arg_356_1.time_ <= 1.79999999701977 + arg_359_0 and not isNil(var_359_18) and arg_356_1.var_.characterEffect1085ui_story == nil then
				arg_356_1.var_.characterEffect1085ui_story = var_359_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_19 = 0.200000002980232

			if 1.79999999701977 <= arg_356_1.time_ and arg_356_1.time_ < 1.79999999701977 + var_359_19 and not isNil(var_359_18) then
				if arg_356_1.var_.characterEffect1085ui_story and not isNil(var_359_18) then
					arg_356_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_356_1.time_ - 1.79999999701977) / var_359_19)
				end
			end

			if arg_356_1.time_ >= 1.79999999701977 + var_359_19 and arg_356_1.time_ < 1.79999999701977 + var_359_19 + arg_359_0 and not isNil(var_359_18) and arg_356_1.var_.characterEffect1085ui_story then
				arg_356_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 3.8 < arg_356_1.time_ and arg_356_1.time_ <= 3.8 + arg_359_0 then
				arg_356_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 3.8 < arg_356_1.time_ and arg_356_1.time_ <= 3.8 + arg_359_0 then
				arg_356_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_359_20 = arg_356_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_356_1.time_ and arg_356_1.time_ <= 1.96599999815226 + arg_359_0 then
				arg_356_1.var_.moveOldPos1085ui_story = var_359_20.localPosition
			end

			local var_359_21 = 0.001

			if 1.96599999815226 <= arg_356_1.time_ and arg_356_1.time_ < 1.96599999815226 + var_359_21 then
				var_359_20.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_356_1.time_ - 1.96599999815226) / var_359_21)
				var_359_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_359_20.position).x, (manager.ui.mainCamera.transform.position - var_359_20.position).y, (manager.ui.mainCamera.transform.position - var_359_20.position).z)
				var_359_20.localEulerAngles.z = 0
				var_359_20.localEulerAngles.x = 0
				var_359_20.localEulerAngles = var_359_20.localEulerAngles
			end

			if arg_356_1.time_ >= 1.96599999815226 + var_359_21 and arg_356_1.time_ < 1.96599999815226 + var_359_21 + arg_359_0 then
				var_359_20.localPosition = Vector3.New(0, 100, 0)
				var_359_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_359_20.position).x, (manager.ui.mainCamera.transform.position - var_359_20.position).y, (manager.ui.mainCamera.transform.position - var_359_20.position).z)
				var_359_20.localEulerAngles.z = 0
				var_359_20.localEulerAngles.x = 0
				var_359_20.localEulerAngles = var_359_20.localEulerAngles
			end

			if arg_356_1.frameCnt_ <= 1 then
				arg_356_1.dialog_:SetActive(false)
			end

			local var_359_22 = 3.999999999999
			local var_359_23 = 0.525

			if 3.999999999999 < arg_356_1.time_ and arg_356_1.time_ <= var_359_22 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0

				arg_356_1.dialog_:SetActive(true)

				arg_356_1.dialogCg_.alpha = 0

				local var_359_24 = LeanTween.value(arg_356_1.dialog_, 0, 1, 0.3)

				var_359_24:setOnUpdate(LuaHelper.FloatAction(function(arg_360_0)
					arg_356_1.dialogCg_.alpha = arg_360_0
				end))
				var_359_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_356_1.dialog_)
					var_359_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_356_1.duration_ = arg_356_1.duration_ + 0.3

				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_25 = arg_356_1:GetWordFromCfg(1108504087)
				local var_359_26 = arg_356_1:FormatText(var_359_25.content)

				arg_356_1.text_.text = var_359_26

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_28 = 21 <= 0 and var_359_23 or var_359_23 * (utf8.len(var_359_26) / 21)

				if (21 <= 0 and var_359_23 or var_359_23 * (utf8.len(var_359_26) / 21)) > 0 and var_359_23 < var_359_28 then
					arg_356_1.talkMaxDuration = var_359_28
					var_359_22 = var_359_22 + 0.3

					if var_359_28 + var_359_22 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_28 + var_359_22
					end
				end

				arg_356_1.text_.text = var_359_26
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb") ~= 0 then
					local var_359_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb") / 1000

					if var_359_29 + var_359_22 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_29 + var_359_22
					end

					if var_359_25.prefab_name ~= "" and arg_356_1.actors_[var_359_25.prefab_name] ~= nil then
						local var_359_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_25.prefab_name].transform, "story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb")

						arg_356_1:RecordAudio("1108504087", var_359_30)
						arg_356_1:RecordAudio("1108504087", var_359_30)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_31 = var_359_22 + 0.3
			local var_359_32 = math.max(var_359_23, arg_356_1.talkMaxDuration)

			if var_359_22 + 0.3 <= arg_356_1.time_ and arg_356_1.time_ < var_359_31 + var_359_32 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_31) / var_359_32

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_31 + var_359_32 and arg_356_1.time_ < var_359_31 + var_359_32 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play1108504088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1108504088
		arg_362_1.duration_ = 2.63

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1108504089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1085ui_story = arg_362_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_365_0 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 then
				arg_362_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_362_1.time_ - 0) / var_365_0)
				arg_362_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1085ui_story"].transform.position).z)
				arg_362_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["1085ui_story"].transform.localEulerAngles = arg_362_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 then
				arg_362_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_362_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1085ui_story"].transform.position).z)
				arg_362_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["1085ui_story"].transform.localEulerAngles = arg_362_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_365_1 = arg_362_1.actors_["1085ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1085ui_story == nil then
				arg_362_1.var_.characterEffect1085ui_story = var_365_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_2 and not isNil(var_365_1) then
				if arg_362_1.var_.characterEffect1085ui_story and not isNil(var_365_1) then
					arg_362_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_2 and arg_362_1.time_ < 0 + var_365_2 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1085ui_story then
				arg_362_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_365_4 = arg_362_1.actors_["10066ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_4) and arg_362_1.var_.characterEffect10066ui_story == nil then
				arg_362_1.var_.characterEffect10066ui_story = var_365_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_5 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_5 and not isNil(var_365_4) then
				if arg_362_1.var_.characterEffect10066ui_story and not isNil(var_365_4) then
					arg_362_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_362_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_5)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_5 and arg_362_1.time_ < 0 + var_365_5 + arg_365_0 and not isNil(var_365_4) and arg_362_1.var_.characterEffect10066ui_story then
				arg_362_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_362_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_365_6 = 0
			local var_365_7 = 0.225

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_8 = arg_362_1:GetWordFromCfg(1108504088)
				local var_365_9 = arg_362_1:FormatText(var_365_8.content)

				arg_362_1.text_.text = var_365_9

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 9 <= 0 and var_365_7 or var_365_7 * (utf8.len(var_365_9) / 9)

				if (9 <= 0 and var_365_7 or var_365_7 * (utf8.len(var_365_9) / 9)) > 0 and var_365_7 < var_365_11 then
					arg_362_1.talkMaxDuration = var_365_11

					if var_365_11 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_11 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_9
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb") ~= 0 then
					local var_365_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb") / 1000

					if var_365_12 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_12 + var_365_6
					end

					if var_365_8.prefab_name ~= "" and arg_362_1.actors_[var_365_8.prefab_name] ~= nil then
						local var_365_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_8.prefab_name].transform, "story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb")

						arg_362_1:RecordAudio("1108504088", var_365_13)
						arg_362_1:RecordAudio("1108504088", var_365_13)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_14 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_6 <= arg_362_1.time_ and arg_362_1.time_ < var_365_6 + var_365_14 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_6) / var_365_14

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_6 + var_365_14 and arg_362_1.time_ < var_365_6 + var_365_14 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1108504089
		arg_366_1.duration_ = 9.6

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1108504090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10066ui_story = arg_366_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10066ui_story"].transform.position).z)
				arg_366_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["10066ui_story"].transform.localEulerAngles = arg_366_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_366_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10066ui_story"].transform.position).z)
				arg_366_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["10066ui_story"].transform.localEulerAngles = arg_366_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_369_1 = arg_366_1.actors_["10066ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect10066ui_story == nil then
				arg_366_1.var_.characterEffect10066ui_story = var_369_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_2 and not isNil(var_369_1) then
				if arg_366_1.var_.characterEffect10066ui_story and not isNil(var_369_1) then
					arg_366_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_2 and arg_366_1.time_ < 0 + var_369_2 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect10066ui_story then
				arg_366_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_369_4 = arg_366_1.actors_["1085ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_4) and arg_366_1.var_.characterEffect1085ui_story == nil then
				arg_366_1.var_.characterEffect1085ui_story = var_369_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_5 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_5 and not isNil(var_369_4) then
				if arg_366_1.var_.characterEffect1085ui_story and not isNil(var_369_4) then
					arg_366_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_5)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_5 and arg_366_1.time_ < 0 + var_369_5 + arg_369_0 and not isNil(var_369_4) and arg_366_1.var_.characterEffect1085ui_story then
				arg_366_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action437")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_369_6 = 0
			local var_369_7 = 0.825

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_8 = arg_366_1:GetWordFromCfg(1108504089)
				local var_369_9 = arg_366_1:FormatText(var_369_8.content)

				arg_366_1.text_.text = var_369_9

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 33 <= 0 and var_369_7 or var_369_7 * (utf8.len(var_369_9) / 33)

				if (33 <= 0 and var_369_7 or var_369_7 * (utf8.len(var_369_9) / 33)) > 0 and var_369_7 < var_369_11 then
					arg_366_1.talkMaxDuration = var_369_11

					if var_369_11 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_11 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_9
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb") ~= 0 then
					local var_369_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb") / 1000

					if var_369_12 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_12 + var_369_6
					end

					if var_369_8.prefab_name ~= "" and arg_366_1.actors_[var_369_8.prefab_name] ~= nil then
						local var_369_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_8.prefab_name].transform, "story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb")

						arg_366_1:RecordAudio("1108504089", var_369_13)
						arg_366_1:RecordAudio("1108504089", var_369_13)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_14 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_14 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_14

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_14 and arg_366_1.time_ < var_369_6 + var_369_14 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play1108504090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1108504090
		arg_370_1.duration_ = 4.17

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1108504091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1085ui_story = arg_370_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_373_0 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 then
				arg_370_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_370_1.time_ - 0) / var_373_0)
				arg_370_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1085ui_story"].transform.position).z)
				arg_370_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1085ui_story"].transform.localEulerAngles = arg_370_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 then
				arg_370_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_370_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1085ui_story"].transform.position).z)
				arg_370_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1085ui_story"].transform.localEulerAngles = arg_370_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_373_1 = arg_370_1.actors_["1085ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1085ui_story == nil then
				arg_370_1.var_.characterEffect1085ui_story = var_373_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_2 and not isNil(var_373_1) then
				if arg_370_1.var_.characterEffect1085ui_story and not isNil(var_373_1) then
					arg_370_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_2 and arg_370_1.time_ < 0 + var_373_2 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1085ui_story then
				arg_370_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_373_4 = arg_370_1.actors_["10066ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect10066ui_story == nil then
				arg_370_1.var_.characterEffect10066ui_story = var_373_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_5 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_5 and not isNil(var_373_4) then
				if arg_370_1.var_.characterEffect10066ui_story and not isNil(var_373_4) then
					arg_370_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_5)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_5 and arg_370_1.time_ < 0 + var_373_5 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect10066ui_story then
				arg_370_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_373_6 = 0
			local var_373_7 = 0.375

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_8 = arg_370_1:GetWordFromCfg(1108504090)
				local var_373_9 = arg_370_1:FormatText(var_373_8.content)

				arg_370_1.text_.text = var_373_9

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_11 = 15 <= 0 and var_373_7 or var_373_7 * (utf8.len(var_373_9) / 15)

				if (15 <= 0 and var_373_7 or var_373_7 * (utf8.len(var_373_9) / 15)) > 0 and var_373_7 < var_373_11 then
					arg_370_1.talkMaxDuration = var_373_11

					if var_373_11 + var_373_6 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_11 + var_373_6
					end
				end

				arg_370_1.text_.text = var_373_9
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb") ~= 0 then
					local var_373_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb") / 1000

					if var_373_12 + var_373_6 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_12 + var_373_6
					end

					if var_373_8.prefab_name ~= "" and arg_370_1.actors_[var_373_8.prefab_name] ~= nil then
						local var_373_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_8.prefab_name].transform, "story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb")

						arg_370_1:RecordAudio("1108504090", var_373_13)
						arg_370_1:RecordAudio("1108504090", var_373_13)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_14 = math.max(var_373_7, arg_370_1.talkMaxDuration)

			if var_373_6 <= arg_370_1.time_ and arg_370_1.time_ < var_373_6 + var_373_14 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_6) / var_373_14

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_6 + var_373_14 and arg_370_1.time_ < var_373_6 + var_373_14 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play1108504091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1108504091
		arg_374_1.duration_ = 4.93

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1108504092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.45

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(1108504091)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 18 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 18)

				if (18 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 18)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb")

						arg_374_1:RecordAudio("1108504091", var_377_6)
						arg_374_1:RecordAudio("1108504091", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1108504092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1108504092
		arg_378_1.duration_ = 4.8

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1108504093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1085ui_story = arg_378_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1085ui_story"].transform.position).z)
				arg_378_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1085ui_story"].transform.localEulerAngles = arg_378_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_378_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1085ui_story"].transform.position).z)
				arg_378_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1085ui_story"].transform.localEulerAngles = arg_378_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_381_1 = 0
			local var_381_2 = 0.375

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:GetWordFromCfg(1108504092)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_6 = 15 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_4) / 15)

				if (15 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_4) / 15)) > 0 and var_381_2 < var_381_6 then
					arg_378_1.talkMaxDuration = var_381_6

					if var_381_6 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb") ~= 0 then
					local var_381_7 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb") / 1000

					if var_381_7 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_1
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb")

						arg_378_1:RecordAudio("1108504092", var_381_8)
						arg_378_1:RecordAudio("1108504092", var_381_8)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_9 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_9 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_9

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_9 and arg_378_1.time_ < var_381_1 + var_381_9 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1108504093
		arg_382_1.duration_ = 5.97

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1108504094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos10066ui_story = arg_382_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["10066ui_story"].transform.position).z)
				arg_382_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["10066ui_story"].transform.localEulerAngles = arg_382_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_382_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["10066ui_story"].transform.position).z)
				arg_382_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["10066ui_story"].transform.localEulerAngles = arg_382_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_385_1 = arg_382_1.actors_["10066ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect10066ui_story == nil then
				arg_382_1.var_.characterEffect10066ui_story = var_385_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_2 and not isNil(var_385_1) then
				if arg_382_1.var_.characterEffect10066ui_story and not isNil(var_385_1) then
					arg_382_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_2 and arg_382_1.time_ < 0 + var_385_2 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect10066ui_story then
				arg_382_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_385_4 = arg_382_1.actors_["1085ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect1085ui_story == nil then
				arg_382_1.var_.characterEffect1085ui_story = var_385_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_5 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_5 and not isNil(var_385_4) then
				if arg_382_1.var_.characterEffect1085ui_story and not isNil(var_385_4) then
					arg_382_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_5)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_5 and arg_382_1.time_ < 0 + var_385_5 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect1085ui_story then
				arg_382_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action473")
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_385_6 = 0
			local var_385_7 = 0.6

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_8 = arg_382_1:GetWordFromCfg(1108504093)
				local var_385_9 = arg_382_1:FormatText(var_385_8.content)

				arg_382_1.text_.text = var_385_9

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_11 = 24 <= 0 and var_385_7 or var_385_7 * (utf8.len(var_385_9) / 24)

				if (24 <= 0 and var_385_7 or var_385_7 * (utf8.len(var_385_9) / 24)) > 0 and var_385_7 < var_385_11 then
					arg_382_1.talkMaxDuration = var_385_11

					if var_385_11 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_11 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_9
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb") ~= 0 then
					local var_385_12 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb") / 1000

					if var_385_12 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_6
					end

					if var_385_8.prefab_name ~= "" and arg_382_1.actors_[var_385_8.prefab_name] ~= nil then
						local var_385_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_8.prefab_name].transform, "story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb")

						arg_382_1:RecordAudio("1108504093", var_385_13)
						arg_382_1:RecordAudio("1108504093", var_385_13)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb")
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
				actorName = "10066ui_story",
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
	Play1108504094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1108504094
		arg_386_1.duration_ = 4.3

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1108504095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 2 < arg_386_1.time_ and arg_386_1.time_ <= 2 + arg_389_0 then
				local var_389_0 = arg_386_1.bgs_.STblack

				arg_386_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_389_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_389_1 = var_389_0:GetComponent("SpriteRenderer")

				if var_389_1 and var_389_1.sprite then
					local var_389_2 = 2 * (var_389_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_389_0.transform.localScale = Vector3.New(var_389_2 / var_389_1.sprite.bounds.size.y < var_389_2 * manager.ui.mainCameraCom_.aspect / var_389_1.sprite.bounds.size.x and var_389_2 * manager.ui.mainCameraCom_.aspect / var_389_1.sprite.bounds.size.x or var_389_2 / var_389_1.sprite.bounds.size.y, var_389_2 / var_389_1.sprite.bounds.size.y < var_389_2 * manager.ui.mainCameraCom_.aspect / var_389_1.sprite.bounds.size.x and var_389_2 * manager.ui.mainCameraCom_.aspect / var_389_1.sprite.bounds.size.x or var_389_2 / var_389_1.sprite.bounds.size.y, 0)
				end

				for iter_389_0, iter_389_1 in pairs(arg_386_1.bgs_) do
					if iter_389_0 ~= "STblack" then
						iter_389_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_389_3 = 4

			if 4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_3 + arg_389_0 then
				arg_386_1.allBtn_.enabled = false
			end

			if arg_386_1.time_ >= var_389_3 + 0.3 and arg_386_1.time_ < var_389_3 + 0.3 + arg_389_0 then
				arg_386_1.allBtn_.enabled = true
			end

			local var_389_4 = 0

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_5 = 2

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_5 then
				local var_389_6 = Color.New(0, 0, 0)

				var_389_6.a = Mathf.Lerp(0, 1, (arg_386_1.time_ - var_389_4) / var_389_5)
				arg_386_1.mask_.color = var_389_6
			end

			if arg_386_1.time_ >= var_389_4 + var_389_5 and arg_386_1.time_ < var_389_4 + var_389_5 + arg_389_0 then
				local var_389_7 = Color.New(0, 0, 0)

				var_389_7.a = 1
				arg_386_1.mask_.color = var_389_7
			end

			local var_389_8 = 2

			if 2 < arg_386_1.time_ and arg_386_1.time_ <= var_389_8 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_9 = 2

			if var_389_8 <= arg_386_1.time_ and arg_386_1.time_ < var_389_8 + var_389_9 then
				local var_389_10 = Color.New(0, 0, 0)

				var_389_10.a = Mathf.Lerp(1, 0, (arg_386_1.time_ - var_389_8) / var_389_9)
				arg_386_1.mask_.color = var_389_10
			end

			if arg_386_1.time_ >= var_389_8 + var_389_9 and arg_386_1.time_ < var_389_8 + var_389_9 + arg_389_0 then
				local var_389_11 = Color.New(0, 0, 0)

				arg_386_1.mask_.enabled = false
				var_389_11.a = 0
				arg_386_1.mask_.color = var_389_11
			end

			local var_389_12 = arg_386_1.actors_["10066ui_story"].transform

			if 1.96599999815226 < arg_386_1.time_ and arg_386_1.time_ <= 1.96599999815226 + arg_389_0 then
				arg_386_1.var_.moveOldPos10066ui_story = var_389_12.localPosition
			end

			local var_389_13 = 0.001

			if 1.96599999815226 <= arg_386_1.time_ and arg_386_1.time_ < 1.96599999815226 + var_389_13 then
				var_389_12.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_386_1.time_ - 1.96599999815226) / var_389_13)
				var_389_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_389_12.position).x, (manager.ui.mainCamera.transform.position - var_389_12.position).y, (manager.ui.mainCamera.transform.position - var_389_12.position).z)
				var_389_12.localEulerAngles.z = 0
				var_389_12.localEulerAngles.x = 0
				var_389_12.localEulerAngles = var_389_12.localEulerAngles
			end

			if arg_386_1.time_ >= 1.96599999815226 + var_389_13 and arg_386_1.time_ < 1.96599999815226 + var_389_13 + arg_389_0 then
				var_389_12.localPosition = Vector3.New(0, 100, 0)
				var_389_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_389_12.position).x, (manager.ui.mainCamera.transform.position - var_389_12.position).y, (manager.ui.mainCamera.transform.position - var_389_12.position).z)
				var_389_12.localEulerAngles.z = 0
				var_389_12.localEulerAngles.x = 0
				var_389_12.localEulerAngles = var_389_12.localEulerAngles
			end

			local var_389_14 = arg_386_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_386_1.time_ and arg_386_1.time_ <= 1.96599999815226 + arg_389_0 then
				arg_386_1.var_.moveOldPos1085ui_story = var_389_14.localPosition
			end

			local var_389_15 = 0.001

			if 1.96599999815226 <= arg_386_1.time_ and arg_386_1.time_ < 1.96599999815226 + var_389_15 then
				var_389_14.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_386_1.time_ - 1.96599999815226) / var_389_15)
				var_389_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_389_14.position).x, (manager.ui.mainCamera.transform.position - var_389_14.position).y, (manager.ui.mainCamera.transform.position - var_389_14.position).z)
				var_389_14.localEulerAngles.z = 0
				var_389_14.localEulerAngles.x = 0
				var_389_14.localEulerAngles = var_389_14.localEulerAngles
			end

			if arg_386_1.time_ >= 1.96599999815226 + var_389_15 and arg_386_1.time_ < 1.96599999815226 + var_389_15 + arg_389_0 then
				var_389_14.localPosition = Vector3.New(0, 100, 0)
				var_389_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_389_14.position).x, (manager.ui.mainCamera.transform.position - var_389_14.position).y, (manager.ui.mainCamera.transform.position - var_389_14.position).z)
				var_389_14.localEulerAngles.z = 0
				var_389_14.localEulerAngles.x = 0
				var_389_14.localEulerAngles = var_389_14.localEulerAngles
			end

			local var_389_16 = arg_386_1.actors_["10066ui_story"]

			if 1.96599999815226 < arg_386_1.time_ and arg_386_1.time_ <= 1.96599999815226 + arg_389_0 and not isNil(var_389_16) and arg_386_1.var_.characterEffect10066ui_story == nil then
				arg_386_1.var_.characterEffect10066ui_story = var_389_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_17 = 0.034000001847744

			if 1.96599999815226 <= arg_386_1.time_ and arg_386_1.time_ < 1.96599999815226 + var_389_17 and not isNil(var_389_16) then
				if arg_386_1.var_.characterEffect10066ui_story and not isNil(var_389_16) then
					arg_386_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_386_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 1.96599999815226) / var_389_17)
				end
			end

			if arg_386_1.time_ >= 1.96599999815226 + var_389_17 and arg_386_1.time_ < 1.96599999815226 + var_389_17 + arg_389_0 and not isNil(var_389_16) and arg_386_1.var_.characterEffect10066ui_story then
				arg_386_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_386_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_386_1.time_ and arg_386_1.time_ <= 0.133333333333333 + arg_389_0 then
				arg_386_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_389_19 = 1.96599999815226
			local var_389_20 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504094", "story_v_side_new_1108504.awb") / 1000

			if var_389_20 > 0 and 1 < var_389_20 and var_389_20 + var_389_19 > arg_386_1.duration_ then
				arg_386_1.duration_ = var_389_20 + var_389_19
			end

			if var_389_19 < arg_386_1.time_ and arg_386_1.time_ <= var_389_19 + arg_389_0 then
				arg_386_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504094", "story_v_side_new_1108504.awb")
			end

			local var_389_22 = 1.96599999815226

			arg_386_1.isInRecall_ = true

			if var_389_22 < arg_386_1.time_ and arg_386_1.time_ <= var_389_22 + arg_389_0 then
				arg_386_1.screenFilterGo_:SetActive(false)

				arg_386_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_386_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_389_2, iter_389_3 in pairs(arg_386_1.actors_) do
					for iter_389_4, iter_389_5 in ipairs((iter_389_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_389_5.color = iter_389_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_389_23 = 0.034000001847744

			if var_389_22 <= arg_386_1.time_ and arg_386_1.time_ < var_389_22 + var_389_23 then
				arg_386_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_386_1.time_ - var_389_22) / var_389_23)
			end

			if arg_386_1.time_ >= var_389_22 + var_389_23 and arg_386_1.time_ < var_389_22 + var_389_23 + arg_389_0 then
				arg_386_1.screenFilterEffect_.weight = 0
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504094,
				charCount = 19,
				enableLayoutChange = true,
				duration = 1.26666666666667,
				groupID = "ningxidawenben1",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play1108504095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1108504095
		arg_390_1.duration_ = 5.57

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1108504096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb") / 1000

			if var_393_0 > 0 and 4.233 < var_393_0 and var_393_0 + 0 > arg_390_1.duration_ then
				arg_390_1.duration_ = var_393_0 + 0
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")
			end

			local var_393_2 = 0
			local var_393_3 = 0.675

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_4 = arg_390_1:GetWordFromCfg(1108504095)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_7 = 27 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 27)

				if (27 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 27)) > 0 and var_393_3 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_2
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb") / 1000

					if var_393_8 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_2
					end

					if var_393_4.prefab_name ~= "" and arg_390_1.actors_[var_393_4.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_4.prefab_name].transform, "story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")

						arg_390_1:RecordAudio("1108504095", var_393_9)
						arg_390_1:RecordAudio("1108504095", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_3, arg_390_1.talkMaxDuration)

			if var_393_2 <= arg_390_1.time_ and arg_390_1.time_ < var_393_2 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_2) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_2 + var_393_10 and arg_390_1.time_ < var_393_2 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504095,
				charCount = 27,
				enableLayoutChange = true,
				duration = 1.8,
				groupID = "ningxidawenben1",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1108504096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1108504096
		arg_394_1.duration_ = 4.23

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1108504097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504096", "story_v_side_new_1108504.awb") / 1000

			if var_397_0 > 0 and 4.233 < var_397_0 and var_397_0 + 0 > arg_394_1.duration_ then
				arg_394_1.duration_ = var_397_0 + 0
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504096", "story_v_side_new_1108504.awb")
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504096,
				charCount = 31,
				enableLayoutChange = true,
				duration = 2.06666666666667,
				groupID = "ningxidawenben1",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play1108504097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1108504097
		arg_398_1.duration_ = 5.33

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1108504098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_401_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_398_1.bgmTxt_.text ~= var_401_2 and arg_398_1.bgmTxt_.text ~= "" then
						if arg_398_1.bgmTxt2_.text ~= "" then
							arg_398_1.bgmTxt_.text = arg_398_1.bgmTxt2_.text
						end

						arg_398_1.bgmTxt2_.text = var_401_2

						arg_398_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_398_1.bgmTxt_.text = var_401_2
						arg_398_1.bgmTxt2_.text = var_401_2
					end

					if arg_398_1.bgmTimer then
						arg_398_1.bgmTimer:Stop()

						arg_398_1.bgmTimer = nil
					end

					if arg_398_1.settingData.show_music_name == 1 then
						arg_398_1.musicController:SetSelectedState("show")
						arg_398_1.musicAnimator_:Play("open", 0, 0)

						if arg_398_1.settingData.music_time ~= 0 then
							arg_398_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_398_1.settingData.music_time), function()
								if arg_398_1 == nil or isNil(arg_398_1.bgmTxt_) then
									return
								end

								arg_398_1.musicController:SetSelectedState("hide")
								arg_398_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_401_3 = 0
			local var_401_4 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504097", "story_v_side_new_1108504.awb") / 1000

			if var_401_4 > 0 and 5.333 < var_401_4 and var_401_4 + var_401_3 > arg_398_1.duration_ then
				arg_398_1.duration_ = var_401_4 + var_401_3
			end

			if var_401_3 < arg_398_1.time_ and arg_398_1.time_ <= var_401_3 + arg_401_0 then
				arg_398_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504097", "story_v_side_new_1108504.awb")
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504097,
				charCount = 18,
				enableLayoutChange = true,
				duration = 1.2,
				groupID = "ningxidawenben1",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play1108504098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1108504098
		arg_403_1.duration_ = 18

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1108504099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 2 < arg_403_1.time_ and arg_403_1.time_ <= 2 + arg_406_0 then
				local var_406_0 = arg_403_1.bgs_.ST12

				arg_403_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_406_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_406_1 = var_406_0:GetComponent("SpriteRenderer")

				if var_406_1 and var_406_1.sprite then
					local var_406_2 = 2 * (var_406_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_406_0.transform.localScale = Vector3.New(var_406_2 / var_406_1.sprite.bounds.size.y < var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x and var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x or var_406_2 / var_406_1.sprite.bounds.size.y, var_406_2 / var_406_1.sprite.bounds.size.y < var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x and var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x or var_406_2 / var_406_1.sprite.bounds.size.y, 0)
				end

				for iter_406_0, iter_406_1 in pairs(arg_403_1.bgs_) do
					if iter_406_0 ~= "ST12" then
						iter_406_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_406_3 = 4.00000000298023

			if 4.00000000298023 < arg_403_1.time_ and arg_403_1.time_ <= var_406_3 + arg_406_0 then
				arg_403_1.allBtn_.enabled = false
			end

			if arg_403_1.time_ >= var_406_3 + 0.3 and arg_403_1.time_ < var_406_3 + 0.3 + arg_406_0 then
				arg_403_1.allBtn_.enabled = true
			end

			local var_406_4 = 0

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_5 = 2

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_5 then
				local var_406_6 = Color.New(0, 0, 0)

				var_406_6.a = Mathf.Lerp(0, 1, (arg_403_1.time_ - var_406_4) / var_406_5)
				arg_403_1.mask_.color = var_406_6
			end

			if arg_403_1.time_ >= var_406_4 + var_406_5 and arg_403_1.time_ < var_406_4 + var_406_5 + arg_406_0 then
				local var_406_7 = Color.New(0, 0, 0)

				var_406_7.a = 1
				arg_403_1.mask_.color = var_406_7
			end

			local var_406_8 = 2

			if 2 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_9 = 2

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_9 then
				local var_406_10 = Color.New(0, 0, 0)

				var_406_10.a = Mathf.Lerp(1, 0, (arg_403_1.time_ - var_406_8) / var_406_9)
				arg_403_1.mask_.color = var_406_10
			end

			if arg_403_1.time_ >= var_406_8 + var_406_9 and arg_403_1.time_ < var_406_8 + var_406_9 + arg_406_0 then
				local var_406_11 = Color.New(0, 0, 0)

				arg_403_1.mask_.enabled = false
				var_406_11.a = 0
				arg_403_1.mask_.color = var_406_11
			end

			local var_406_12 = arg_403_1.actors_["1085ui_story"].transform

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 then
				arg_403_1.var_.moveOldPos1085ui_story = var_406_12.localPosition
			end

			local var_406_13 = 0.001

			if 3.8 <= arg_403_1.time_ and arg_403_1.time_ < 3.8 + var_406_13 then
				var_406_12.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_403_1.time_ - 3.8) / var_406_13)
				var_406_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_12.position).x, (manager.ui.mainCamera.transform.position - var_406_12.position).y, (manager.ui.mainCamera.transform.position - var_406_12.position).z)
				var_406_12.localEulerAngles.z = 0
				var_406_12.localEulerAngles.x = 0
				var_406_12.localEulerAngles = var_406_12.localEulerAngles
			end

			if arg_403_1.time_ >= 3.8 + var_406_13 and arg_403_1.time_ < 3.8 + var_406_13 + arg_406_0 then
				var_406_12.localPosition = Vector3.New(0, -1.01, -5.83)
				var_406_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_12.position).x, (manager.ui.mainCamera.transform.position - var_406_12.position).y, (manager.ui.mainCamera.transform.position - var_406_12.position).z)
				var_406_12.localEulerAngles.z = 0
				var_406_12.localEulerAngles.x = 0
				var_406_12.localEulerAngles = var_406_12.localEulerAngles
			end

			local var_406_14 = arg_403_1.actors_["1085ui_story"]

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 and not isNil(var_406_14) and arg_403_1.var_.characterEffect1085ui_story == nil then
				arg_403_1.var_.characterEffect1085ui_story = var_406_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_15 = 0.200000002980232

			if 3.8 <= arg_403_1.time_ and arg_403_1.time_ < 3.8 + var_406_15 and not isNil(var_406_14) then
				if arg_403_1.var_.characterEffect1085ui_story and not isNil(var_406_14) then
					arg_403_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 3.8 + var_406_15 and arg_403_1.time_ < 3.8 + var_406_15 + arg_406_0 and not isNil(var_406_14) and arg_403_1.var_.characterEffect1085ui_story then
				arg_403_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 then
				arg_403_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 then
				arg_403_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 1.63333333333333 < arg_403_1.time_ and arg_403_1.time_ <= 1.63333333333333 + arg_406_0 then
				arg_403_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_403_1.frameCnt_ <= 1 then
				arg_403_1.dialog_:SetActive(false)
			end

			local var_406_18 = 4
			local var_406_19 = 1

			if 4 < arg_403_1.time_ and arg_403_1.time_ <= var_406_18 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				arg_403_1.dialog_:SetActive(true)

				arg_403_1.dialogCg_.alpha = 0

				local var_406_20 = LeanTween.value(arg_403_1.dialog_, 0, 1, 0.3)

				var_406_20:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_403_1.dialogCg_.alpha = arg_407_0
				end))
				var_406_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_403_1.dialog_)
					var_406_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_403_1.duration_ = arg_403_1.duration_ + 0.3

				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_21 = arg_403_1:GetWordFromCfg(1108504098)
				local var_406_22 = arg_403_1:FormatText(var_406_21.content)

				arg_403_1.text_.text = var_406_22

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_24 = 42 <= 0 and var_406_19 or var_406_19 * (utf8.len(var_406_22) / 42)

				if (42 <= 0 and var_406_19 or var_406_19 * (utf8.len(var_406_22) / 42)) > 0 and var_406_19 < var_406_24 then
					arg_403_1.talkMaxDuration = var_406_24
					var_406_18 = var_406_18 + 0.3

					if var_406_24 + var_406_18 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_24 + var_406_18
					end
				end

				arg_403_1.text_.text = var_406_22
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb") ~= 0 then
					local var_406_25 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb") / 1000

					if var_406_25 + var_406_18 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_25 + var_406_18
					end

					if var_406_21.prefab_name ~= "" and arg_403_1.actors_[var_406_21.prefab_name] ~= nil then
						local var_406_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_21.prefab_name].transform, "story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb")

						arg_403_1:RecordAudio("1108504098", var_406_26)
						arg_403_1:RecordAudio("1108504098", var_406_26)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_27 = var_406_18 + 0.3
			local var_406_28 = math.max(var_406_19, arg_403_1.talkMaxDuration)

			if var_406_18 + 0.3 <= arg_403_1.time_ and arg_403_1.time_ < var_406_27 + var_406_28 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_27) / var_406_28

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_27 + var_406_28 and arg_403_1.time_ < var_406_27 + var_406_28 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "ningxidawenben1",
				duration = 0.133333333333333,
				className = "StoryTextGroupNode",
				startTime = 1.86666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1108504099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1108504099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1108504100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1085ui_story = arg_409_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1085ui_story"].transform.position).z)
				arg_409_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1085ui_story"].transform.localEulerAngles = arg_409_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1085ui_story"].transform.position).z)
				arg_409_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1085ui_story"].transform.localEulerAngles = arg_409_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["1085ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1085ui_story == nil then
				arg_409_1.var_.characterEffect1085ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect1085ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_2)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1085ui_story then
				arg_409_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_412_3 = 0
			local var_412_4 = 0.875

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_3 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_5 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1108504099).content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 35 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_5) / 35)

				if (35 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_5) / 35)) > 0 and var_412_4 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_3 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_3
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_8 = math.max(var_412_4, arg_409_1.talkMaxDuration)

			if var_412_3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_3 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_3) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_3 + var_412_8 and arg_409_1.time_ < var_412_3 + var_412_8 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1108504100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1108504101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.275

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1108504100).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 11 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 11)

				if (11 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 11)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1108504101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1108504101
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1108504102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.675

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

				local var_420_1 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1108504101).content)

				arg_417_1.text_.text = var_420_1

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_3 = 27 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 27)

				if (27 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 27)) > 0 and var_420_0 < var_420_3 then
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
	Play1108504102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1108504102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1108504103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 1

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

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1108504102).content)

				arg_421_1.text_.text = var_424_1

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_3 = 40 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 40)

				if (40 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 40)) > 0 and var_424_0 < var_424_3 then
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
	Play1108504103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1108504103
		arg_425_1.duration_ = 5.3

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1108504104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_428_0 = 0.3

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				local var_428_1, var_428_2 = math.modf((arg_425_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_428_2 * 0.13, var_428_2 * 0.13, var_428_2 * 0.13) + arg_425_1.var_.shakeOldPos
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				manager.ui.mainCamera.transform.localPosition = arg_425_1.var_.shakeOldPos
			end

			local var_428_3 = 0

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			if arg_425_1.time_ >= var_428_3 + 0.3 and arg_425_1.time_ < var_428_3 + 0.3 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end

			if 2.77555756156289e-17 < arg_425_1.time_ and arg_425_1.time_ <= 2.77555756156289e-17 + arg_428_0 then
				arg_425_1:AudioAction("play", "effect", "se_story_148", "se_story_148_hold", "")
			end

			if arg_425_1.frameCnt_ <= 1 then
				arg_425_1.dialog_:SetActive(false)
			end

			local var_428_5 = 0.3
			local var_428_6 = 1.05

			if 0.3 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0

				arg_425_1.dialog_:SetActive(true)

				arg_425_1.dialogCg_.alpha = 0

				local var_428_7 = LeanTween.value(arg_425_1.dialog_, 0, 1, 0.3)

				var_428_7:setOnUpdate(LuaHelper.FloatAction(function(arg_429_0)
					arg_425_1.dialogCg_.alpha = arg_429_0
				end))
				var_428_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_425_1.dialog_)
					var_428_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_425_1.duration_ = arg_425_1.duration_ + 0.3

				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_8 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1108504103).content)

				arg_425_1.text_.text = var_428_8

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_10 = 42 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_8) / 42)

				if (42 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_8) / 42)) > 0 and var_428_6 < var_428_10 then
					arg_425_1.talkMaxDuration = var_428_10
					var_428_5 = var_428_5 + 0.3

					if var_428_10 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_5
					end
				end

				arg_425_1.text_.text = var_428_8
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_11 = var_428_5 + 0.3
			local var_428_12 = math.max(var_428_6, arg_425_1.talkMaxDuration)

			if var_428_5 + 0.3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_11 + var_428_12 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_11) / var_428_12

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_11 + var_428_12 and arg_425_1.time_ < var_428_11 + var_428_12 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1108504104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1108504104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1108504105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.1

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1108504104).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 44 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 44)

				if (44 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 44)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1108504105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1108504105
		arg_435_1.duration_ = 3.97

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1108504106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1085ui_story = arg_435_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1085ui_story"].transform.position).z)
				arg_435_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1085ui_story"].transform.localEulerAngles = arg_435_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_435_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1085ui_story"].transform.position).z)
				arg_435_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1085ui_story"].transform.localEulerAngles = arg_435_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1085ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1085ui_story == nil then
				arg_435_1.var_.characterEffect1085ui_story = var_438_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 and not isNil(var_438_1) then
				if arg_435_1.var_.characterEffect1085ui_story and not isNil(var_438_1) then
					arg_435_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1085ui_story then
				arg_435_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_438_4 = 0
			local var_438_5 = 0.325

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_6 = arg_435_1:GetWordFromCfg(1108504105)
				local var_438_7 = arg_435_1:FormatText(var_438_6.content)

				arg_435_1.text_.text = var_438_7

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_9 = 13 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 13)

				if (13 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 13)) > 0 and var_438_5 < var_438_9 then
					arg_435_1.talkMaxDuration = var_438_9

					if var_438_9 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_4
					end
				end

				arg_435_1.text_.text = var_438_7
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb") ~= 0 then
					local var_438_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb") / 1000

					if var_438_10 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_4
					end

					if var_438_6.prefab_name ~= "" and arg_435_1.actors_[var_438_6.prefab_name] ~= nil then
						local var_438_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_6.prefab_name].transform, "story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb")

						arg_435_1:RecordAudio("1108504105", var_438_11)
						arg_435_1:RecordAudio("1108504105", var_438_11)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_5, arg_435_1.talkMaxDuration)

			if var_438_4 <= arg_435_1.time_ and arg_435_1.time_ < var_438_4 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_4) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_4 + var_438_12 and arg_435_1.time_ < var_438_4 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play1108504106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1108504106
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1108504107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1085ui_story"]) and arg_439_1.var_.characterEffect1085ui_story == nil then
				arg_439_1.var_.characterEffect1085ui_story = arg_439_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1085ui_story"]) then
				if arg_439_1.var_.characterEffect1085ui_story and not isNil(arg_439_1.actors_["1085ui_story"]) then
					arg_439_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_0)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1085ui_story"]) and arg_439_1.var_.characterEffect1085ui_story then
				arg_439_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_442_1 = 0
			local var_442_2 = 0.525

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1108504106).content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 21 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 21)

				if (21 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 21)) > 0 and var_442_2 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_1
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_6 = math.max(var_442_2, arg_439_1.talkMaxDuration)

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_6 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_1) / var_442_6

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_1 + var_442_6 and arg_439_1.time_ < var_442_1 + var_442_6 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1108504107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1108504107
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1108504108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1085ui_story = arg_443_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1085ui_story"].transform.position).z)
				arg_443_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1085ui_story"].transform.localEulerAngles = arg_443_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_443_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1085ui_story"].transform.position).z)
				arg_443_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1085ui_story"].transform.localEulerAngles = arg_443_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_446_1 = 0
			local var_446_2 = 0.65

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1108504107).content)

				arg_443_1.text_.text = var_446_3

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 26 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 26)

				if (26 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 26)) > 0 and var_446_2 < var_446_5 then
					arg_443_1.talkMaxDuration = var_446_5

					if var_446_5 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + var_446_1
					end
				end

				arg_443_1.text_.text = var_446_3
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_6 = math.max(var_446_2, arg_443_1.talkMaxDuration)

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_6 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_1) / var_446_6

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_1 + var_446_6 and arg_443_1.time_ < var_446_1 + var_446_6 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1108504108
		arg_447_1.duration_ = 9

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1108504109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if arg_447_1.bgs_.ST12a == nil then
				local var_450_0 = Object.Instantiate(arg_447_1.paintGo_)

				var_450_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12a")
				var_450_0.name = "ST12a"
				var_450_0.transform.parent = arg_447_1.stage_.transform
				var_450_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.bgs_.ST12a = var_450_0
			end

			if 2 < arg_447_1.time_ and arg_447_1.time_ <= 2 + arg_450_0 then
				local var_450_1 = arg_447_1.bgs_.ST12a

				arg_447_1.bgs_.ST12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_450_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_450_2 = var_450_1:GetComponent("SpriteRenderer")

				if var_450_2 and var_450_2.sprite then
					local var_450_3 = 2 * (var_450_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_450_1.transform.localScale = Vector3.New(var_450_3 / var_450_2.sprite.bounds.size.y < var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x and var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x or var_450_3 / var_450_2.sprite.bounds.size.y, var_450_3 / var_450_2.sprite.bounds.size.y < var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x and var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x or var_450_3 / var_450_2.sprite.bounds.size.y, 0)
				end

				for iter_450_0, iter_450_1 in pairs(arg_447_1.bgs_) do
					if iter_450_0 ~= "ST12a" then
						iter_450_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_450_4 = 4

			if 4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
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

			if arg_447_1.frameCnt_ <= 1 then
				arg_447_1.dialog_:SetActive(false)
			end

			local var_450_13 = 4
			local var_450_14 = 0.65

			if 4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_13 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0

				arg_447_1.dialog_:SetActive(true)

				arg_447_1.dialogCg_.alpha = 0

				local var_450_15 = LeanTween.value(arg_447_1.dialog_, 0, 1, 0.3)

				var_450_15:setOnUpdate(LuaHelper.FloatAction(function(arg_451_0)
					arg_447_1.dialogCg_.alpha = arg_451_0
				end))
				var_450_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_447_1.dialog_)
					var_450_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_447_1.duration_ = arg_447_1.duration_ + 0.3

				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_16 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1108504108).content)

				arg_447_1.text_.text = var_450_16

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_18 = 26 <= 0 and var_450_14 or var_450_14 * (utf8.len(var_450_16) / 26)

				if (26 <= 0 and var_450_14 or var_450_14 * (utf8.len(var_450_16) / 26)) > 0 and var_450_14 < var_450_18 then
					arg_447_1.talkMaxDuration = var_450_18
					var_450_13 = var_450_13 + 0.3

					if var_450_18 + var_450_13 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_18 + var_450_13
					end
				end

				arg_447_1.text_.text = var_450_16
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_19 = var_450_13 + 0.3
			local var_450_20 = math.max(var_450_14, arg_447_1.talkMaxDuration)

			if var_450_13 + 0.3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_19 + var_450_20 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_19) / var_450_20

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_19 + var_450_20 and arg_447_1.time_ < var_450_19 + var_450_20 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1108504109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1108504109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1108504110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.5

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1108504109).content)

				arg_453_1.text_.text = var_456_1

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_3 = 20 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 20)

				if (20 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 20)) > 0 and var_456_0 < var_456_3 then
					arg_453_1.talkMaxDuration = var_456_3

					if var_456_3 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_3 + 0
					end
				end

				arg_453_1.text_.text = var_456_1
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_4 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_4

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1108504110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1108504110
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1108504111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.35

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
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

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1108504110).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 14 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 14)

				if (14 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 14)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1108504111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1108504111
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1108504112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1.075

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1108504111).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 43 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 43)

				if (43 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 43)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1108504112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1108504112
		arg_465_1.duration_ = 9

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1108504113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if arg_465_1.bgs_.R8501 == nil then
				local var_468_0 = Object.Instantiate(arg_465_1.paintGo_)

				var_468_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8501")
				var_468_0.name = "R8501"
				var_468_0.transform.parent = arg_465_1.stage_.transform
				var_468_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.bgs_.R8501 = var_468_0
			end

			if 2 < arg_465_1.time_ and arg_465_1.time_ <= 2 + arg_468_0 then
				local var_468_1 = arg_465_1.bgs_.R8501

				arg_465_1.bgs_.R8501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_468_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_468_2 = var_468_1:GetComponent("SpriteRenderer")

				if var_468_2 and var_468_2.sprite then
					local var_468_3 = 2 * (var_468_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_468_1.transform.localScale = Vector3.New(var_468_3 / var_468_2.sprite.bounds.size.y < var_468_3 * manager.ui.mainCameraCom_.aspect / var_468_2.sprite.bounds.size.x and var_468_3 * manager.ui.mainCameraCom_.aspect / var_468_2.sprite.bounds.size.x or var_468_3 / var_468_2.sprite.bounds.size.y, var_468_3 / var_468_2.sprite.bounds.size.y < var_468_3 * manager.ui.mainCameraCom_.aspect / var_468_2.sprite.bounds.size.x and var_468_3 * manager.ui.mainCameraCom_.aspect / var_468_2.sprite.bounds.size.x or var_468_3 / var_468_2.sprite.bounds.size.y, 0)
				end

				for iter_468_0, iter_468_1 in pairs(arg_465_1.bgs_) do
					if iter_468_0 ~= "R8501" then
						iter_468_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_468_4 = 4

			if 4 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			if arg_465_1.time_ >= var_468_4 + 0.3 and arg_465_1.time_ < var_468_4 + 0.3 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			local var_468_5 = 0

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_5 + arg_468_0 then
				arg_465_1.mask_.enabled = true
				arg_465_1.mask_.raycastTarget = true

				arg_465_1:SetGaussion(false)
			end

			local var_468_6 = 2

			if var_468_5 <= arg_465_1.time_ and arg_465_1.time_ < var_468_5 + var_468_6 then
				local var_468_7 = Color.New(0, 0, 0)

				var_468_7.a = Mathf.Lerp(0, 1, (arg_465_1.time_ - var_468_5) / var_468_6)
				arg_465_1.mask_.color = var_468_7
			end

			if arg_465_1.time_ >= var_468_5 + var_468_6 and arg_465_1.time_ < var_468_5 + var_468_6 + arg_468_0 then
				local var_468_8 = Color.New(0, 0, 0)

				var_468_8.a = 1
				arg_465_1.mask_.color = var_468_8
			end

			local var_468_9 = 2

			if 2 < arg_465_1.time_ and arg_465_1.time_ <= var_468_9 + arg_468_0 then
				arg_465_1.mask_.enabled = true
				arg_465_1.mask_.raycastTarget = true

				arg_465_1:SetGaussion(false)
			end

			local var_468_10 = 2

			if var_468_9 <= arg_465_1.time_ and arg_465_1.time_ < var_468_9 + var_468_10 then
				local var_468_11 = Color.New(0, 0, 0)

				var_468_11.a = Mathf.Lerp(1, 0, (arg_465_1.time_ - var_468_9) / var_468_10)
				arg_465_1.mask_.color = var_468_11
			end

			if arg_465_1.time_ >= var_468_9 + var_468_10 and arg_465_1.time_ < var_468_9 + var_468_10 + arg_468_0 then
				local var_468_12 = Color.New(0, 0, 0)

				arg_465_1.mask_.enabled = false
				var_468_12.a = 0
				arg_465_1.mask_.color = var_468_12
			end

			if 0.333333333333333 < arg_465_1.time_ and arg_465_1.time_ <= 0.333333333333333 + arg_468_0 then
				arg_465_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_468_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_465_1.bgmTxt_.text ~= var_468_15 and arg_465_1.bgmTxt_.text ~= "" then
						if arg_465_1.bgmTxt2_.text ~= "" then
							arg_465_1.bgmTxt_.text = arg_465_1.bgmTxt2_.text
						end

						arg_465_1.bgmTxt2_.text = var_468_15

						arg_465_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_465_1.bgmTxt_.text = var_468_15
						arg_465_1.bgmTxt2_.text = var_468_15
					end

					if arg_465_1.bgmTimer then
						arg_465_1.bgmTimer:Stop()

						arg_465_1.bgmTimer = nil
					end

					if arg_465_1.settingData.show_music_name == 1 then
						arg_465_1.musicController:SetSelectedState("show")
						arg_465_1.musicAnimator_:Play("open", 0, 0)

						if arg_465_1.settingData.music_time ~= 0 then
							arg_465_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_465_1.settingData.music_time), function()
								if arg_465_1 == nil or isNil(arg_465_1.bgmTxt_) then
									return
								end

								arg_465_1.musicController:SetSelectedState("hide")
								arg_465_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_465_1.time_ and arg_465_1.time_ <= 1.63333333333333 + arg_468_0 then
				arg_465_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_468_18 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_465_1.bgmTxt_.text ~= var_468_18 and arg_465_1.bgmTxt_.text ~= "" then
						if arg_465_1.bgmTxt2_.text ~= "" then
							arg_465_1.bgmTxt_.text = arg_465_1.bgmTxt2_.text
						end

						arg_465_1.bgmTxt2_.text = var_468_18

						arg_465_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_465_1.bgmTxt_.text = var_468_18
						arg_465_1.bgmTxt2_.text = var_468_18
					end

					if arg_465_1.bgmTimer then
						arg_465_1.bgmTimer:Stop()

						arg_465_1.bgmTimer = nil
					end

					if arg_465_1.settingData.show_music_name == 1 then
						arg_465_1.musicController:SetSelectedState("show")
						arg_465_1.musicAnimator_:Play("open", 0, 0)

						if arg_465_1.settingData.music_time ~= 0 then
							arg_465_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_465_1.settingData.music_time), function()
								if arg_465_1 == nil or isNil(arg_465_1.bgmTxt_) then
									return
								end

								arg_465_1.musicController:SetSelectedState("hide")
								arg_465_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_468_19 = arg_465_1.bgs_.R8501.transform

			if 2 < arg_465_1.time_ and arg_465_1.time_ <= 2 + arg_468_0 then
				arg_465_1.var_.moveOldPosR8501 = var_468_19.localPosition
			end

			local var_468_20 = 3.5

			if 2 <= arg_465_1.time_ and arg_465_1.time_ < 2 + var_468_20 then
				var_468_19.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPosR8501, Vector3.New(0, 1, 2), (arg_465_1.time_ - 2) / var_468_20)
			end

			if arg_465_1.time_ >= 2 + var_468_20 and arg_465_1.time_ < 2 + var_468_20 + arg_468_0 then
				var_468_19.localPosition = Vector3.New(0, 1, 2)
			end

			local var_468_21 = 4

			if 4 < arg_465_1.time_ and arg_465_1.time_ <= var_468_21 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			if arg_465_1.time_ >= var_468_21 + 1.5 and arg_465_1.time_ < var_468_21 + 1.5 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			if arg_465_1.frameCnt_ <= 1 then
				arg_465_1.dialog_:SetActive(false)
			end

			local var_468_22 = 4
			local var_468_23 = 0.5

			if 4 < arg_465_1.time_ and arg_465_1.time_ <= var_468_22 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0

				arg_465_1.dialog_:SetActive(true)

				arg_465_1.dialogCg_.alpha = 0

				local var_468_24 = LeanTween.value(arg_465_1.dialog_, 0, 1, 0.3)

				var_468_24:setOnUpdate(LuaHelper.FloatAction(function(arg_471_0)
					arg_465_1.dialogCg_.alpha = arg_471_0
				end))
				var_468_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_465_1.dialog_)
					var_468_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_465_1.duration_ = arg_465_1.duration_ + 0.3

				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_25 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1108504112).content)

				arg_465_1.text_.text = var_468_25

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_27 = 20 <= 0 and var_468_23 or var_468_23 * (utf8.len(var_468_25) / 20)

				if (20 <= 0 and var_468_23 or var_468_23 * (utf8.len(var_468_25) / 20)) > 0 and var_468_23 < var_468_27 then
					arg_465_1.talkMaxDuration = var_468_27
					var_468_22 = var_468_22 + 0.3

					if var_468_27 + var_468_22 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_27 + var_468_22
					end
				end

				arg_465_1.text_.text = var_468_25
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_28 = var_468_22 + 0.3
			local var_468_29 = math.max(var_468_23, arg_465_1.talkMaxDuration)

			if var_468_22 + 0.3 <= arg_465_1.time_ and arg_465_1.time_ < var_468_28 + var_468_29 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_28) / var_468_29

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_28 + var_468_29 and arg_465_1.time_ < var_468_28 + var_468_29 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R8501",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.5, 2),
					endPos = Vector3.New(0, 1, 2),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play1108504113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1108504113
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1108504114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.5

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
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

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1108504113).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 20 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 20)

				if (20 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 20)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1108504114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1108504114
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1108504115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.25

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1108504114).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 10 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 10)

				if (10 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 10)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1108504115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1108504115
		arg_481_1.duration_ = 1.9

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1108504116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.1

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:GetWordFromCfg(1108504115)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 4 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 4)

				if (4 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 4)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb")

						arg_481_1:RecordAudio("1108504115", var_484_6)
						arg_481_1:RecordAudio("1108504115", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1108504116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1108504116
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1108504117(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1085ui_story"]) and arg_485_1.var_.characterEffect1085ui_story == nil then
				arg_485_1.var_.characterEffect1085ui_story = arg_485_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1085ui_story"]) then
				if arg_485_1.var_.characterEffect1085ui_story and not isNil(arg_485_1.actors_["1085ui_story"]) then
					arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_0)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1085ui_story"]) and arg_485_1.var_.characterEffect1085ui_story then
				arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_488_1 = 0
			local var_488_2 = 0.125

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1108504116).content)

				arg_485_1.text_.text = var_488_3

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 5 <= 0 and var_488_2 or var_488_2 * (utf8.len(var_488_3) / 5)

				if (5 <= 0 and var_488_2 or var_488_2 * (utf8.len(var_488_3) / 5)) > 0 and var_488_2 < var_488_5 then
					arg_485_1.talkMaxDuration = var_488_5

					if var_488_5 + var_488_1 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + var_488_1
					end
				end

				arg_485_1.text_.text = var_488_3
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_6 = math.max(var_488_2, arg_485_1.talkMaxDuration)

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_6 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_1) / var_488_6

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_1 + var_488_6 and arg_485_1.time_ < var_488_1 + var_488_6 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1108504117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1108504117
		arg_489_1.duration_ = 4.93

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1108504118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.225

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:GetWordFromCfg(1108504117)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 9 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 9)

				if (9 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 9)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb")

						arg_489_1:RecordAudio("1108504117", var_492_6)
						arg_489_1:RecordAudio("1108504117", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1108504118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1108504118
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1108504119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1085ui_story = arg_493_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1085ui_story"].transform.position).z)
				arg_493_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1085ui_story"].transform.localEulerAngles = arg_493_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1085ui_story"].transform.position).z)
				arg_493_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1085ui_story"].transform.localEulerAngles = arg_493_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1085ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1085ui_story == nil then
				arg_493_1.var_.characterEffect1085ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1085ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_2)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1085ui_story then
				arg_493_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_496_3 = 0
			local var_496_4 = 0.875

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_3 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_5 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(1108504118).content)

				arg_493_1.text_.text = var_496_5

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_7 = 35 <= 0 and var_496_4 or var_496_4 * (utf8.len(var_496_5) / 35)

				if (35 <= 0 and var_496_4 or var_496_4 * (utf8.len(var_496_5) / 35)) > 0 and var_496_4 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_3 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_3
					end
				end

				arg_493_1.text_.text = var_496_5
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_8 = math.max(var_496_4, arg_493_1.talkMaxDuration)

			if var_496_3 <= arg_493_1.time_ and arg_493_1.time_ < var_496_3 + var_496_8 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_3) / var_496_8

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_3 + var_496_8 and arg_493_1.time_ < var_496_3 + var_496_8 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1108504119 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1108504119
		arg_497_1.duration_ = 3.13

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1108504120(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.175

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0

				arg_497_1.dialog_:SetActive(true)

				arg_497_1.dialogCg_.alpha = 0

				local var_500_2 = LeanTween.value(arg_497_1.dialog_, 0, 1, 0.3)

				var_500_2:setOnUpdate(LuaHelper.FloatAction(function(arg_501_0)
					arg_497_1.dialogCg_.alpha = arg_501_0
				end))
				var_500_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_497_1.dialog_)
					var_500_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_497_1.duration_ = arg_497_1.duration_ + 0.3

				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:GetWordFromCfg(1108504119)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_6 = 7 <= 0 and var_500_1 or var_500_1 * (utf8.len(var_500_4) / 7)

				if (7 <= 0 and var_500_1 or var_500_1 * (utf8.len(var_500_4) / 7)) > 0 and var_500_1 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6
					var_500_0 = var_500_0 + 0.3

					if var_500_6 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb") ~= 0 then
					local var_500_7 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb") / 1000

					if var_500_7 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_0
					end

					if var_500_3.prefab_name ~= "" and arg_497_1.actors_[var_500_3.prefab_name] ~= nil then
						local var_500_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_3.prefab_name].transform, "story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb")

						arg_497_1:RecordAudio("1108504119", var_500_8)
						arg_497_1:RecordAudio("1108504119", var_500_8)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_9 = var_500_0 + 0.3
			local var_500_10 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 + 0.3 <= arg_497_1.time_ and arg_497_1.time_ < var_500_9 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_9) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_9 + var_500_10 and arg_497_1.time_ < var_500_9 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1108504120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1108504120
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1108504121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1085ui_story"]) and arg_503_1.var_.characterEffect1085ui_story == nil then
				arg_503_1.var_.characterEffect1085ui_story = arg_503_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1085ui_story"]) then
				if arg_503_1.var_.characterEffect1085ui_story and not isNil(arg_503_1.actors_["1085ui_story"]) then
					arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_0)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1085ui_story"]) and arg_503_1.var_.characterEffect1085ui_story then
				arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_506_1 = 0
			local var_506_2 = 0.6

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(1108504120).content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 24 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 24)

				if (24 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 24)) > 0 and var_506_2 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_1
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_6 = math.max(var_506_2, arg_503_1.talkMaxDuration)

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_6 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_1) / var_506_6

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_1 + var_506_6 and arg_503_1.time_ < var_506_1 + var_506_6 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1108504121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1108504121
		arg_507_1.duration_ = 6.47

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1108504122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.325

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:GetWordFromCfg(1108504121)
				local var_510_2 = arg_507_1:FormatText(var_510_1.content)

				arg_507_1.text_.text = var_510_2

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 13 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 13)

				if (13 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 13)) > 0 and var_510_0 < var_510_4 then
					arg_507_1.talkMaxDuration = var_510_4

					if var_510_4 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_4 + 0
					end
				end

				arg_507_1.text_.text = var_510_2
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb") ~= 0 then
					local var_510_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb") / 1000

					if var_510_5 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + 0
					end

					if var_510_1.prefab_name ~= "" and arg_507_1.actors_[var_510_1.prefab_name] ~= nil then
						local var_510_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_1.prefab_name].transform, "story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb")

						arg_507_1:RecordAudio("1108504121", var_510_6)
						arg_507_1:RecordAudio("1108504121", var_510_6)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1108504122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1108504122
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1108504123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1085ui_story"]) and arg_511_1.var_.characterEffect1085ui_story == nil then
				arg_511_1.var_.characterEffect1085ui_story = arg_511_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1085ui_story"]) then
				if arg_511_1.var_.characterEffect1085ui_story and not isNil(arg_511_1.actors_["1085ui_story"]) then
					arg_511_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_0)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1085ui_story"]) and arg_511_1.var_.characterEffect1085ui_story then
				arg_511_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_514_1 = 0
			local var_514_2 = 0.225

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(1108504122).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 9 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 9)

				if (9 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 9)) > 0 and var_514_2 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_6 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_6 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_6

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_6 and arg_511_1.time_ < var_514_1 + var_514_6 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1108504123 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1108504123
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1108504124(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1085ui_story = arg_515_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).z)
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles = arg_515_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_515_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).z)
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles = arg_515_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_518_1 = 0
			local var_518_2 = 0.975

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_3 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(1108504123).content)

				arg_515_1.text_.text = var_518_3

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 39 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 39)

				if (39 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 39)) > 0 and var_518_2 < var_518_5 then
					arg_515_1.talkMaxDuration = var_518_5

					if var_518_5 + var_518_1 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + var_518_1
					end
				end

				arg_515_1.text_.text = var_518_3
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_6 = math.max(var_518_2, arg_515_1.talkMaxDuration)

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_6 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_1) / var_518_6

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_1 + var_518_6 and arg_515_1.time_ < var_518_1 + var_518_6 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play1108504124 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1108504124
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1108504125(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.65

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_1 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(1108504124).content)

				arg_519_1.text_.text = var_522_1

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_3 = 26 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 26)

				if (26 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 26)) > 0 and var_522_0 < var_522_3 then
					arg_519_1.talkMaxDuration = var_522_3

					if var_522_3 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_3 + 0
					end
				end

				arg_519_1.text_.text = var_522_1
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_4 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_4

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1108504125 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1108504125
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1108504126(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.15

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1108504125).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 6 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 6)

				if (6 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 6)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1108504126 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1108504126
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1108504127(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.775

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1108504126).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 31 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 31)

				if (31 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 31)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1108504127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1108504127
		arg_531_1.duration_ = 9.83

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1108504128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_9001
			local var_534_9000

			if arg_531_1.bgs_.R8501a == nil then
				local var_534_0 = Object.Instantiate(arg_531_1.paintGo_)

				var_534_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8501a")
				var_534_0.name = "R8501a"
				var_534_0.transform.parent = arg_531_1.stage_.transform
				var_534_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.bgs_.R8501a = var_534_0
			end

			if 1.16666666666667 < arg_531_1.time_ and arg_531_1.time_ <= 1.16666666666667 + arg_534_0 then
				local var_534_1 = arg_531_1.bgs_.R8501a

				arg_531_1.bgs_.R8501a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_534_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_534_2 = var_534_1:GetComponent("SpriteRenderer")

				if var_534_2 and var_534_2.sprite then
					local var_534_3 = 2 * (var_534_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_534_1.transform.localScale = Vector3.New(var_534_3 / var_534_2.sprite.bounds.size.y < var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x and var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x or var_534_3 / var_534_2.sprite.bounds.size.y, var_534_3 / var_534_2.sprite.bounds.size.y < var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x and var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x or var_534_3 / var_534_2.sprite.bounds.size.y, 0)
				end

				for iter_534_0, iter_534_1 in pairs(arg_531_1.bgs_) do
					if iter_534_0 ~= "R8501a" then
						iter_534_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_534_4 = 2.05833333333333

			if 2.05833333333333 < arg_531_1.time_ and arg_531_1.time_ <= var_534_4 + arg_534_0 then
				arg_531_1.allBtn_.enabled = false
			end

			if arg_531_1.time_ >= var_534_4 + 0.3 and arg_531_1.time_ < var_534_4 + 0.3 + arg_534_0 then
				arg_531_1.allBtn_.enabled = true
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				local var_534_5 = arg_531_1.var_.effectyewanzhuanchang1

				if not arg_531_1.var_.effectyewanzhuanchang1 then
					var_534_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_in_keep"), manager.ui.mainCamera.transform)
					var_534_5.name = "yewanzhuanchang1"
					arg_531_1.var_.effectyewanzhuanchang1 = var_534_5
				else
					var_534_5.transform:SetParent(var_534_9001)
				end

				var_534_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_534_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.4 < arg_531_1.time_ and arg_531_1.time_ <= 1.4 + arg_534_0 then
				if arg_531_1.var_.effectyewanzhuanchang1 then
					Object.Destroy(arg_531_1.var_.effectyewanzhuanchang1)

					arg_531_1.var_.effectyewanzhuanchang1 = nil
				end
			end

			if 1.4 < arg_531_1.time_ and arg_531_1.time_ <= 1.4 + arg_534_0 then
				local var_534_8 = arg_531_1.var_.effectyewanzhuanchang2

				if not arg_531_1.var_.effectyewanzhuanchang2 then
					var_534_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_out"), manager.ui.mainCamera.transform)
					var_534_8.name = "yewanzhuanchang2"
					arg_531_1.var_.effectyewanzhuanchang2 = var_534_8
				else
					var_534_8.transform:SetParent(var_534_9000)
				end

				var_534_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_534_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_534_10 = arg_531_1.bgs_.R8501a.transform

			if 1.16666666666667 < arg_531_1.time_ and arg_531_1.time_ <= 1.16666666666667 + arg_534_0 then
				arg_531_1.var_.moveOldPosR8501a = var_534_10.localPosition
			end

			local var_534_11 = 2.71666666666667

			if 1.16666666666667 <= arg_531_1.time_ and arg_531_1.time_ < 1.16666666666667 + var_534_11 then
				var_534_10.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPosR8501a, Vector3.New(0, 1, 10), (arg_531_1.time_ - 1.16666666666667) / var_534_11)
			end

			if arg_531_1.time_ >= 1.16666666666667 + var_534_11 and arg_531_1.time_ < 1.16666666666667 + var_534_11 + arg_534_0 then
				var_534_10.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_12 = 2.03333333333333
			local var_534_13 = 0.325

			if 2.03333333333333 < arg_531_1.time_ and arg_531_1.time_ <= var_534_12 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_14 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_14:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_15 = arg_531_1:GetWordFromCfg(1108504127)
				local var_534_16 = arg_531_1:FormatText(var_534_15.content)

				arg_531_1.text_.text = var_534_16

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_18 = 13 <= 0 and var_534_13 or var_534_13 * (utf8.len(var_534_16) / 13)

				if (13 <= 0 and var_534_13 or var_534_13 * (utf8.len(var_534_16) / 13)) > 0 and var_534_13 < var_534_18 then
					arg_531_1.talkMaxDuration = var_534_18
					var_534_12 = var_534_12 + 0.3

					if var_534_18 + var_534_12 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_18 + var_534_12
					end
				end

				arg_531_1.text_.text = var_534_16
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb") ~= 0 then
					local var_534_19 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb") / 1000

					if var_534_19 + var_534_12 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_19 + var_534_12
					end

					if var_534_15.prefab_name ~= "" and arg_531_1.actors_[var_534_15.prefab_name] ~= nil then
						local var_534_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_15.prefab_name].transform, "story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb")

						arg_531_1:RecordAudio("1108504127", var_534_20)
						arg_531_1:RecordAudio("1108504127", var_534_20)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_21 = var_534_12 + 0.3
			local var_534_22 = math.max(var_534_13, arg_531_1.talkMaxDuration)

			if var_534_12 + 0.3 <= arg_531_1.time_ and arg_531_1.time_ < var_534_21 + var_534_22 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_21) / var_534_22

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_21 + var_534_22 and arg_531_1.time_ < var_534_21 + var_534_22 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R8501a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.71666666666667,
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play1108504128 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1108504128
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1108504129(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.5

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1108504128).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 20 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 20)

				if (20 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 20)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1108504129 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1108504129
		arg_541_1.duration_ = 4.73

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1108504130(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.325

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_1 = arg_541_1:GetWordFromCfg(1108504129)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 13 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 13)

				if (13 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 13)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb")

						arg_541_1:RecordAudio("1108504129", var_544_6)
						arg_541_1:RecordAudio("1108504129", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1108504130 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1108504130
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1108504131(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0.85

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_1 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(1108504130).content)

				arg_545_1.text_.text = var_548_1

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_3 = 34 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 34)

				if (34 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 34)) > 0 and var_548_0 < var_548_3 then
					arg_545_1.talkMaxDuration = var_548_3

					if var_548_3 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_3 + 0
					end
				end

				arg_545_1.text_.text = var_548_1
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_4 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_4

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1108504131 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1108504131
		arg_549_1.duration_ = 5.13

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1108504132(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.325

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:GetWordFromCfg(1108504131)
				local var_552_2 = arg_549_1:FormatText(var_552_1.content)

				arg_549_1.text_.text = var_552_2

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 13 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 13)

				if (13 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 13)) > 0 and var_552_0 < var_552_4 then
					arg_549_1.talkMaxDuration = var_552_4

					if var_552_4 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_4 + 0
					end
				end

				arg_549_1.text_.text = var_552_2
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb") ~= 0 then
					local var_552_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb") / 1000

					if var_552_5 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + 0
					end

					if var_552_1.prefab_name ~= "" and arg_549_1.actors_[var_552_1.prefab_name] ~= nil then
						local var_552_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_1.prefab_name].transform, "story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb")

						arg_549_1:RecordAudio("1108504131", var_552_6)
						arg_549_1:RecordAudio("1108504131", var_552_6)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_7 and arg_549_1.time_ < 0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1108504132 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1108504132
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1108504133(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0.225

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_1 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(1108504132).content)

				arg_553_1.text_.text = var_556_1

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_3 = 9 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 9)

				if (9 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 9)) > 0 and var_556_0 < var_556_3 then
					arg_553_1.talkMaxDuration = var_556_3

					if var_556_3 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_3 + 0
					end
				end

				arg_553_1.text_.text = var_556_1
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_4 = math.max(var_556_0, arg_553_1.talkMaxDuration)

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - 0) / var_556_4

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1108504133 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1108504133
		arg_557_1.duration_ = 10.57

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1108504134(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.675

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_1 = arg_557_1:GetWordFromCfg(1108504133)
				local var_560_2 = arg_557_1:FormatText(var_560_1.content)

				arg_557_1.text_.text = var_560_2

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 27 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 27)

				if (27 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 27)) > 0 and var_560_0 < var_560_4 then
					arg_557_1.talkMaxDuration = var_560_4

					if var_560_4 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_4 + 0
					end
				end

				arg_557_1.text_.text = var_560_2
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb") ~= 0 then
					local var_560_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb") / 1000

					if var_560_5 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + 0
					end

					if var_560_1.prefab_name ~= "" and arg_557_1.actors_[var_560_1.prefab_name] ~= nil then
						local var_560_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_1.prefab_name].transform, "story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb")

						arg_557_1:RecordAudio("1108504133", var_560_6)
						arg_557_1:RecordAudio("1108504133", var_560_6)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_7 and arg_557_1.time_ < 0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1108504134 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1108504134
		arg_561_1.duration_ = 3.97

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1108504135(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.3

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_1 = arg_561_1:GetWordFromCfg(1108504134)
				local var_564_2 = arg_561_1:FormatText(var_564_1.content)

				arg_561_1.text_.text = var_564_2

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 12 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 12)

				if (12 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 12)) > 0 and var_564_0 < var_564_4 then
					arg_561_1.talkMaxDuration = var_564_4

					if var_564_4 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_4 + 0
					end
				end

				arg_561_1.text_.text = var_564_2
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb") ~= 0 then
					local var_564_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb") / 1000

					if var_564_5 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + 0
					end

					if var_564_1.prefab_name ~= "" and arg_561_1.actors_[var_564_1.prefab_name] ~= nil then
						local var_564_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_1.prefab_name].transform, "story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb")

						arg_561_1:RecordAudio("1108504134", var_564_6)
						arg_561_1:RecordAudio("1108504134", var_564_6)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_7 and arg_561_1.time_ < 0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1108504135 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1108504135
		arg_565_1.duration_ = 1

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"

			SetActive(arg_565_1.choicesGo_, true)

			for iter_566_0, iter_566_1 in ipairs(arg_565_1.choices_) do
				SetActive(iter_566_1.go, iter_566_0 <= 2)
			end

			arg_565_1.choices_[1].txt.text = arg_565_1:FormatText(StoryChoiceCfg[1638].name)
			arg_565_1.choices_[2].txt.text = arg_565_1:FormatText(StoryChoiceCfg[1639].name)
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1108504136(arg_565_1)
			end

			if arg_567_0 == 2 then
				arg_565_0:Play1108504138(arg_565_1)
			end

			arg_565_1:RecordChoiceLog(1108504135, 1638, 1639)
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.allBtn_.enabled = false
			end

			if arg_565_1.time_ >= 0 + 0.6 and arg_565_1.time_ < 0 + 0.6 + arg_568_0 then
				arg_565_1.allBtn_.enabled = true
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1108504136 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1108504136
		arg_569_1.duration_ = 4.23

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1108504137(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.3

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_1 = arg_569_1:GetWordFromCfg(1108504136)
				local var_572_2 = arg_569_1:FormatText(var_572_1.content)

				arg_569_1.text_.text = var_572_2

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_4 = 12 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 12)

				if (12 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 12)) > 0 and var_572_0 < var_572_4 then
					arg_569_1.talkMaxDuration = var_572_4

					if var_572_4 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_4 + 0
					end
				end

				arg_569_1.text_.text = var_572_2
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb") ~= 0 then
					local var_572_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb") / 1000

					if var_572_5 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + 0
					end

					if var_572_1.prefab_name ~= "" and arg_569_1.actors_[var_572_1.prefab_name] ~= nil then
						local var_572_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_1.prefab_name].transform, "story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb")

						arg_569_1:RecordAudio("1108504136", var_572_6)
						arg_569_1:RecordAudio("1108504136", var_572_6)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_7 and arg_569_1.time_ < 0 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1108504137 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1108504137
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1108504140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0.25

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_1 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(1108504137).content)

				arg_573_1.text_.text = var_576_1

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_3 = 10 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_1) / 10)

				if (10 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_1) / 10)) > 0 and var_576_0 < var_576_3 then
					arg_573_1.talkMaxDuration = var_576_3

					if var_576_3 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_3 + 0
					end
				end

				arg_573_1.text_.text = var_576_1
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_4 = math.max(var_576_0, arg_573_1.talkMaxDuration)

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_4 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - 0) / var_576_4

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= 0 + var_576_4 and arg_573_1.time_ < 0 + var_576_4 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1108504140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1108504140
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1108504141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0.45

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_1 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(1108504140).content)

				arg_577_1.text_.text = var_580_1

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_3 = 18 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 18)

				if (18 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 18)) > 0 and var_580_0 < var_580_3 then
					arg_577_1.talkMaxDuration = var_580_3

					if var_580_3 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_3 + 0
					end
				end

				arg_577_1.text_.text = var_580_1
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_4 = math.max(var_580_0, arg_577_1.talkMaxDuration)

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_4 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - 0) / var_580_4

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= 0 + var_580_4 and arg_577_1.time_ < 0 + var_580_4 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1108504141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1108504141
		arg_581_1.duration_ = 2.73

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1108504142(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0.2

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_1 = arg_581_1:GetWordFromCfg(1108504141)
				local var_584_2 = arg_581_1:FormatText(var_584_1.content)

				arg_581_1.text_.text = var_584_2

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_4 = 8 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_2) / 8)

				if (8 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_2) / 8)) > 0 and var_584_0 < var_584_4 then
					arg_581_1.talkMaxDuration = var_584_4

					if var_584_4 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_4 + 0
					end
				end

				arg_581_1.text_.text = var_584_2
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb") ~= 0 then
					local var_584_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb") / 1000

					if var_584_5 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_5 + 0
					end

					if var_584_1.prefab_name ~= "" and arg_581_1.actors_[var_584_1.prefab_name] ~= nil then
						local var_584_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_1.prefab_name].transform, "story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb")

						arg_581_1:RecordAudio("1108504141", var_584_6)
						arg_581_1:RecordAudio("1108504141", var_584_6)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_7 = math.max(var_584_0, arg_581_1.talkMaxDuration)

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_7 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - 0) / var_584_7

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= 0 + var_584_7 and arg_581_1.time_ < 0 + var_584_7 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1108504142 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1108504142
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1108504143(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.45

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(1108504142).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 18 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 18)

				if (18 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 18)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1108504143 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1108504143
		arg_589_1.duration_ = 7.87

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1108504144(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.475

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:GetWordFromCfg(1108504143)
				local var_592_2 = arg_589_1:FormatText(var_592_1.content)

				arg_589_1.text_.text = var_592_2

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_4 = 19 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 19)

				if (19 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 19)) > 0 and var_592_0 < var_592_4 then
					arg_589_1.talkMaxDuration = var_592_4

					if var_592_4 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_4 + 0
					end
				end

				arg_589_1.text_.text = var_592_2
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb") ~= 0 then
					local var_592_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb") / 1000

					if var_592_5 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + 0
					end

					if var_592_1.prefab_name ~= "" and arg_589_1.actors_[var_592_1.prefab_name] ~= nil then
						local var_592_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_1.prefab_name].transform, "story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb")

						arg_589_1:RecordAudio("1108504143", var_592_6)
						arg_589_1:RecordAudio("1108504143", var_592_6)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_7 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_7 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_7

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_7 and arg_589_1.time_ < 0 + var_592_7 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1108504144 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1108504144
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1108504145(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.625

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(1108504144).content)

				arg_593_1.text_.text = var_596_1

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_3 = 25 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 25)

				if (25 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 25)) > 0 and var_596_0 < var_596_3 then
					arg_593_1.talkMaxDuration = var_596_3

					if var_596_3 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_3 + 0
					end
				end

				arg_593_1.text_.text = var_596_1
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_4 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_4 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_4

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_4 and arg_593_1.time_ < 0 + var_596_4 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1108504145 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1108504145
		arg_597_1.duration_ = 9

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1108504146(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 2 < arg_597_1.time_ and arg_597_1.time_ <= 2 + arg_600_0 then
				local var_600_0 = arg_597_1.bgs_.ST12a

				arg_597_1.bgs_.ST12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_600_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_600_1 = var_600_0:GetComponent("SpriteRenderer")

				if var_600_1 and var_600_1.sprite then
					local var_600_2 = 2 * (var_600_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_600_0.transform.localScale = Vector3.New(var_600_2 / var_600_1.sprite.bounds.size.y < var_600_2 * manager.ui.mainCameraCom_.aspect / var_600_1.sprite.bounds.size.x and var_600_2 * manager.ui.mainCameraCom_.aspect / var_600_1.sprite.bounds.size.x or var_600_2 / var_600_1.sprite.bounds.size.y, var_600_2 / var_600_1.sprite.bounds.size.y < var_600_2 * manager.ui.mainCameraCom_.aspect / var_600_1.sprite.bounds.size.x and var_600_2 * manager.ui.mainCameraCom_.aspect / var_600_1.sprite.bounds.size.x or var_600_2 / var_600_1.sprite.bounds.size.y, 0)
				end

				for iter_600_0, iter_600_1 in pairs(arg_597_1.bgs_) do
					if iter_600_0 ~= "ST12a" then
						iter_600_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_600_3 = 4

			if 4 < arg_597_1.time_ and arg_597_1.time_ <= var_600_3 + arg_600_0 then
				arg_597_1.allBtn_.enabled = false
			end

			if arg_597_1.time_ >= var_600_3 + 0.3 and arg_597_1.time_ < var_600_3 + 0.3 + arg_600_0 then
				arg_597_1.allBtn_.enabled = true
			end

			local var_600_4 = 0

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_4 + arg_600_0 then
				arg_597_1.mask_.enabled = true
				arg_597_1.mask_.raycastTarget = true

				arg_597_1:SetGaussion(false)
			end

			local var_600_5 = 2

			if var_600_4 <= arg_597_1.time_ and arg_597_1.time_ < var_600_4 + var_600_5 then
				local var_600_6 = Color.New(0, 0, 0)

				var_600_6.a = Mathf.Lerp(0, 1, (arg_597_1.time_ - var_600_4) / var_600_5)
				arg_597_1.mask_.color = var_600_6
			end

			if arg_597_1.time_ >= var_600_4 + var_600_5 and arg_597_1.time_ < var_600_4 + var_600_5 + arg_600_0 then
				local var_600_7 = Color.New(0, 0, 0)

				var_600_7.a = 1
				arg_597_1.mask_.color = var_600_7
			end

			local var_600_8 = 2

			if 2 < arg_597_1.time_ and arg_597_1.time_ <= var_600_8 + arg_600_0 then
				arg_597_1.mask_.enabled = true
				arg_597_1.mask_.raycastTarget = true

				arg_597_1:SetGaussion(false)
			end

			local var_600_9 = 2

			if var_600_8 <= arg_597_1.time_ and arg_597_1.time_ < var_600_8 + var_600_9 then
				local var_600_10 = Color.New(0, 0, 0)

				var_600_10.a = Mathf.Lerp(1, 0, (arg_597_1.time_ - var_600_8) / var_600_9)
				arg_597_1.mask_.color = var_600_10
			end

			if arg_597_1.time_ >= var_600_8 + var_600_9 and arg_597_1.time_ < var_600_8 + var_600_9 + arg_600_0 then
				local var_600_11 = Color.New(0, 0, 0)

				arg_597_1.mask_.enabled = false
				var_600_11.a = 0
				arg_597_1.mask_.color = var_600_11
			end

			if arg_597_1.frameCnt_ <= 1 then
				arg_597_1.dialog_:SetActive(false)
			end

			local var_600_12 = 4
			local var_600_13 = 0.325

			if 4 < arg_597_1.time_ and arg_597_1.time_ <= var_600_12 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0

				arg_597_1.dialog_:SetActive(true)

				arg_597_1.dialogCg_.alpha = 0

				local var_600_14 = LeanTween.value(arg_597_1.dialog_, 0, 1, 0.3)

				var_600_14:setOnUpdate(LuaHelper.FloatAction(function(arg_601_0)
					arg_597_1.dialogCg_.alpha = arg_601_0
				end))
				var_600_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_597_1.dialog_)
					var_600_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_597_1.duration_ = arg_597_1.duration_ + 0.3

				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, true)
				arg_597_1.iconController_:SetSelectedState("hero")

				arg_597_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_597_1.callingController_:SetSelectedState("normal")

				arg_597_1.keyicon_.color = Color.New(1, 1, 1)
				arg_597_1.icon_.color = Color.New(1, 1, 1)

				local var_600_15 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(1108504145).content)

				arg_597_1.text_.text = var_600_15

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_17 = 13 <= 0 and var_600_13 or var_600_13 * (utf8.len(var_600_15) / 13)

				if (13 <= 0 and var_600_13 or var_600_13 * (utf8.len(var_600_15) / 13)) > 0 and var_600_13 < var_600_17 then
					arg_597_1.talkMaxDuration = var_600_17
					var_600_12 = var_600_12 + 0.3

					if var_600_17 + var_600_12 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_17 + var_600_12
					end
				end

				arg_597_1.text_.text = var_600_15
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_18 = var_600_12 + 0.3
			local var_600_19 = math.max(var_600_13, arg_597_1.talkMaxDuration)

			if var_600_12 + 0.3 <= arg_597_1.time_ and arg_597_1.time_ < var_600_18 + var_600_19 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_18) / var_600_19

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_18 + var_600_19 and arg_597_1.time_ < var_600_18 + var_600_19 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1108504146 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1108504146
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1108504147(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0.266666666666667 < arg_603_1.time_ and arg_603_1.time_ <= 0.266666666666667 + arg_606_0 then
				arg_603_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_606_1 = 0
			local var_606_2 = 0.775

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_3 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(1108504146).content)

				arg_603_1.text_.text = var_606_3

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_5 = 31 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_3) / 31)

				if (31 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_3) / 31)) > 0 and var_606_2 < var_606_5 then
					arg_603_1.talkMaxDuration = var_606_5

					if var_606_5 + var_606_1 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_5 + var_606_1
					end
				end

				arg_603_1.text_.text = var_606_3
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_6 = math.max(var_606_2, arg_603_1.talkMaxDuration)

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_6 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_1) / var_606_6

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_1 + var_606_6 and arg_603_1.time_ < var_606_1 + var_606_6 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1108504147 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1108504147
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1108504148(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.1

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_1 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(1108504147).content)

				arg_607_1.text_.text = var_610_1

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_3 = 4 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 4)

				if (4 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 4)) > 0 and var_610_0 < var_610_3 then
					arg_607_1.talkMaxDuration = var_610_3

					if var_610_3 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_3 + 0
					end
				end

				arg_607_1.text_.text = var_610_1
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_4 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_4 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_4

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_4 and arg_607_1.time_ < 0 + var_610_4 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1108504148 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1108504148
		arg_611_1.duration_ = 3.43

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1108504149(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos1085ui_story = arg_611_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_614_0 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 then
				arg_611_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_611_1.time_ - 0) / var_614_0)
				arg_611_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_611_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["1085ui_story"].transform.position).z)
				arg_611_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_611_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_611_1.actors_["1085ui_story"].transform.localEulerAngles = arg_611_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 then
				arg_611_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_611_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_611_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["1085ui_story"].transform.position).z)
				arg_611_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_611_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_611_1.actors_["1085ui_story"].transform.localEulerAngles = arg_611_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_614_1 = arg_611_1.actors_["1085ui_story"]

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(var_614_1) and arg_611_1.var_.characterEffect1085ui_story == nil then
				arg_611_1.var_.characterEffect1085ui_story = var_614_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_2 and not isNil(var_614_1) then
				if arg_611_1.var_.characterEffect1085ui_story and not isNil(var_614_1) then
					arg_611_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= 0 + var_614_2 and arg_611_1.time_ < 0 + var_614_2 + arg_614_0 and not isNil(var_614_1) and arg_611_1.var_.characterEffect1085ui_story then
				arg_611_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_614_4 = 0
			local var_614_5 = 0.25

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_4 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_6 = arg_611_1:GetWordFromCfg(1108504148)
				local var_614_7 = arg_611_1:FormatText(var_614_6.content)

				arg_611_1.text_.text = var_614_7

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_9 = 10 <= 0 and var_614_5 or var_614_5 * (utf8.len(var_614_7) / 10)

				if (10 <= 0 and var_614_5 or var_614_5 * (utf8.len(var_614_7) / 10)) > 0 and var_614_5 < var_614_9 then
					arg_611_1.talkMaxDuration = var_614_9

					if var_614_9 + var_614_4 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_9 + var_614_4
					end
				end

				arg_611_1.text_.text = var_614_7
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb") ~= 0 then
					local var_614_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb") / 1000

					if var_614_10 + var_614_4 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_10 + var_614_4
					end

					if var_614_6.prefab_name ~= "" and arg_611_1.actors_[var_614_6.prefab_name] ~= nil then
						local var_614_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_6.prefab_name].transform, "story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb")

						arg_611_1:RecordAudio("1108504148", var_614_11)
						arg_611_1:RecordAudio("1108504148", var_614_11)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_12 = math.max(var_614_5, arg_611_1.talkMaxDuration)

			if var_614_4 <= arg_611_1.time_ and arg_611_1.time_ < var_614_4 + var_614_12 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_4) / var_614_12

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_4 + var_614_12 and arg_611_1.time_ < var_614_4 + var_614_12 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_611_1:InitPlayNodeList()
	end,
	Play1108504149 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1108504149
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1108504150(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(arg_615_1.actors_["1085ui_story"]) and arg_615_1.var_.characterEffect1085ui_story == nil then
				arg_615_1.var_.characterEffect1085ui_story = arg_615_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_0 = 0.200000002980232

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 and not isNil(arg_615_1.actors_["1085ui_story"]) then
				if arg_615_1.var_.characterEffect1085ui_story and not isNil(arg_615_1.actors_["1085ui_story"]) then
					arg_615_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_615_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_615_1.time_ - 0) / var_618_0)
				end
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 and not isNil(arg_615_1.actors_["1085ui_story"]) and arg_615_1.var_.characterEffect1085ui_story then
				arg_615_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_615_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_618_1 = 0
			local var_618_2 = 0.325

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_3 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(1108504149).content)

				arg_615_1.text_.text = var_618_3

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 13 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 13)

				if (13 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 13)) > 0 and var_618_2 < var_618_5 then
					arg_615_1.talkMaxDuration = var_618_5

					if var_618_5 + var_618_1 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_5 + var_618_1
					end
				end

				arg_615_1.text_.text = var_618_3
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_6 = math.max(var_618_2, arg_615_1.talkMaxDuration)

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_6 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_1) / var_618_6

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_1 + var_618_6 and arg_615_1.time_ < var_618_1 + var_618_6 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1108504150 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1108504150
		arg_619_1.duration_ = 7.27

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1108504151(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos1085ui_story = arg_619_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_622_0 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 then
				arg_619_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_619_1.time_ - 0) / var_622_0)
				arg_619_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1085ui_story"].transform.position).z)
				arg_619_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1085ui_story"].transform.localEulerAngles = arg_619_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 then
				arg_619_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_619_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1085ui_story"].transform.position).z)
				arg_619_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1085ui_story"].transform.localEulerAngles = arg_619_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_622_1 = arg_619_1.actors_["1085ui_story"]

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect1085ui_story == nil then
				arg_619_1.var_.characterEffect1085ui_story = var_622_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_2 and not isNil(var_622_1) then
				if arg_619_1.var_.characterEffect1085ui_story and not isNil(var_622_1) then
					arg_619_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= 0 + var_622_2 and arg_619_1.time_ < 0 + var_622_2 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect1085ui_story then
				arg_619_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_622_4 = 0
			local var_622_5 = 0.625

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_4 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_6 = arg_619_1:GetWordFromCfg(1108504150)
				local var_622_7 = arg_619_1:FormatText(var_622_6.content)

				arg_619_1.text_.text = var_622_7

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_9 = 25 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 25)

				if (25 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 25)) > 0 and var_622_5 < var_622_9 then
					arg_619_1.talkMaxDuration = var_622_9

					if var_622_9 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_9 + var_622_4
					end
				end

				arg_619_1.text_.text = var_622_7
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb") ~= 0 then
					local var_622_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb") / 1000

					if var_622_10 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_10 + var_622_4
					end

					if var_622_6.prefab_name ~= "" and arg_619_1.actors_[var_622_6.prefab_name] ~= nil then
						local var_622_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_6.prefab_name].transform, "story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb")

						arg_619_1:RecordAudio("1108504150", var_622_11)
						arg_619_1:RecordAudio("1108504150", var_622_11)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_12 = math.max(var_622_5, arg_619_1.talkMaxDuration)

			if var_622_4 <= arg_619_1.time_ and arg_619_1.time_ < var_622_4 + var_622_12 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_4) / var_622_12

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_4 + var_622_12 and arg_619_1.time_ < var_622_4 + var_622_12 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play1108504151 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1108504151
		arg_623_1.duration_ = 4.87

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1108504152(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_626_0 = 0
			local var_626_1 = 0.45

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_0 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_2 = arg_623_1:GetWordFromCfg(1108504151)
				local var_626_3 = arg_623_1:FormatText(var_626_2.content)

				arg_623_1.text_.text = var_626_3

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_5 = 18 <= 0 and var_626_1 or var_626_1 * (utf8.len(var_626_3) / 18)

				if (18 <= 0 and var_626_1 or var_626_1 * (utf8.len(var_626_3) / 18)) > 0 and var_626_1 < var_626_5 then
					arg_623_1.talkMaxDuration = var_626_5

					if var_626_5 + var_626_0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_5 + var_626_0
					end
				end

				arg_623_1.text_.text = var_626_3
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb") ~= 0 then
					local var_626_6 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb") / 1000

					if var_626_6 + var_626_0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_6 + var_626_0
					end

					if var_626_2.prefab_name ~= "" and arg_623_1.actors_[var_626_2.prefab_name] ~= nil then
						local var_626_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_2.prefab_name].transform, "story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb")

						arg_623_1:RecordAudio("1108504151", var_626_7)
						arg_623_1:RecordAudio("1108504151", var_626_7)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_8 = math.max(var_626_1, arg_623_1.talkMaxDuration)

			if var_626_0 <= arg_623_1.time_ and arg_623_1.time_ < var_626_0 + var_626_8 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_0) / var_626_8

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_0 + var_626_8 and arg_623_1.time_ < var_626_0 + var_626_8 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1108504152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1108504152
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1108504153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1085ui_story"]) and arg_627_1.var_.characterEffect1085ui_story == nil then
				arg_627_1.var_.characterEffect1085ui_story = arg_627_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.200000002980232

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1085ui_story"]) then
				if arg_627_1.var_.characterEffect1085ui_story and not isNil(arg_627_1.actors_["1085ui_story"]) then
					arg_627_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_627_1.time_ - 0) / var_630_0)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1085ui_story"]) and arg_627_1.var_.characterEffect1085ui_story then
				arg_627_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_630_1 = 0
			local var_630_2 = 0.525

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_3 = arg_627_1:FormatText(arg_627_1:GetWordFromCfg(1108504152).content)

				arg_627_1.text_.text = var_630_3

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_5 = 21 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_3) / 21)

				if (21 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_3) / 21)) > 0 and var_630_2 < var_630_5 then
					arg_627_1.talkMaxDuration = var_630_5

					if var_630_5 + var_630_1 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_5 + var_630_1
					end
				end

				arg_627_1.text_.text = var_630_3
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_6 = math.max(var_630_2, arg_627_1.talkMaxDuration)

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_6 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_1) / var_630_6

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_1 + var_630_6 and arg_627_1.time_ < var_630_1 + var_630_6 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1108504153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1108504153
		arg_631_1.duration_ = 2.67

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1108504154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1085ui_story"]) and arg_631_1.var_.characterEffect1085ui_story == nil then
				arg_631_1.var_.characterEffect1085ui_story = arg_631_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1085ui_story"]) then
				if arg_631_1.var_.characterEffect1085ui_story and not isNil(arg_631_1.actors_["1085ui_story"]) then
					arg_631_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1085ui_story"]) and arg_631_1.var_.characterEffect1085ui_story then
				arg_631_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_634_2 = 0
			local var_634_3 = 0.125

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_2 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_4 = arg_631_1:GetWordFromCfg(1108504153)
				local var_634_5 = arg_631_1:FormatText(var_634_4.content)

				arg_631_1.text_.text = var_634_5

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_7 = 5 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_5) / 5)

				if (5 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_5) / 5)) > 0 and var_634_3 < var_634_7 then
					arg_631_1.talkMaxDuration = var_634_7

					if var_634_7 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_7 + var_634_2
					end
				end

				arg_631_1.text_.text = var_634_5
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb") ~= 0 then
					local var_634_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb") / 1000

					if var_634_8 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_8 + var_634_2
					end

					if var_634_4.prefab_name ~= "" and arg_631_1.actors_[var_634_4.prefab_name] ~= nil then
						local var_634_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_4.prefab_name].transform, "story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb")

						arg_631_1:RecordAudio("1108504153", var_634_9)
						arg_631_1:RecordAudio("1108504153", var_634_9)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_10 = math.max(var_634_3, arg_631_1.talkMaxDuration)

			if var_634_2 <= arg_631_1.time_ and arg_631_1.time_ < var_634_2 + var_634_10 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_2) / var_634_10

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_2 + var_634_10 and arg_631_1.time_ < var_634_2 + var_634_10 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1108504154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1108504154
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1108504155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1085ui_story = arg_635_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_638_0 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 then
				arg_635_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_635_1.time_ - 0) / var_638_0)
				arg_635_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1085ui_story"].transform.position).z)
				arg_635_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1085ui_story"].transform.localEulerAngles = arg_635_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 then
				arg_635_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_635_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1085ui_story"].transform.position).z)
				arg_635_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1085ui_story"].transform.localEulerAngles = arg_635_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_638_1 = arg_635_1.actors_["1085ui_story"]

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1085ui_story == nil then
				arg_635_1.var_.characterEffect1085ui_story = var_638_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_2 and not isNil(var_638_1) then
				if arg_635_1.var_.characterEffect1085ui_story and not isNil(var_638_1) then
					arg_635_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_635_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_635_1.time_ - 0) / var_638_2)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_2 and arg_635_1.time_ < 0 + var_638_2 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1085ui_story then
				arg_635_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_635_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_638_3 = 0
			local var_638_4 = 0.7

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_3 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_5 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(1108504154).content)

				arg_635_1.text_.text = var_638_5

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_7 = 28 <= 0 and var_638_4 or var_638_4 * (utf8.len(var_638_5) / 28)

				if (28 <= 0 and var_638_4 or var_638_4 * (utf8.len(var_638_5) / 28)) > 0 and var_638_4 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_3 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_3
					end
				end

				arg_635_1.text_.text = var_638_5
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_8 = math.max(var_638_4, arg_635_1.talkMaxDuration)

			if var_638_3 <= arg_635_1.time_ and arg_635_1.time_ < var_638_3 + var_638_8 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_3) / var_638_8

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_3 + var_638_8 and arg_635_1.time_ < var_638_3 + var_638_8 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_635_1:InitPlayNodeList()
	end,
	Play1108504155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1108504155
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1108504156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 1.4

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_1 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(1108504155).content)

				arg_639_1.text_.text = var_642_1

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_3 = 56 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 56)

				if (56 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 56)) > 0 and var_642_0 < var_642_3 then
					arg_639_1.talkMaxDuration = var_642_3

					if var_642_3 + 0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_3 + 0
					end
				end

				arg_639_1.text_.text = var_642_1
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_4 = math.max(var_642_0, arg_639_1.talkMaxDuration)

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_4 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - 0) / var_642_4

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= 0 + var_642_4 and arg_639_1.time_ < 0 + var_642_4 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1108504156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1108504156
		arg_643_1.duration_ = 5.5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1108504157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.var_.moveOldPos1085ui_story = arg_643_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_646_0 = 0.001

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 then
				arg_643_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_643_1.time_ - 0) / var_646_0)
				arg_643_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1085ui_story"].transform.position).z)
				arg_643_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1085ui_story"].transform.localEulerAngles = arg_643_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 then
				arg_643_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_643_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1085ui_story"].transform.position).z)
				arg_643_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1085ui_story"].transform.localEulerAngles = arg_643_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_646_1 = arg_643_1.actors_["1085ui_story"]

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect1085ui_story == nil then
				arg_643_1.var_.characterEffect1085ui_story = var_646_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.200000002980232

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_2 and not isNil(var_646_1) then
				if arg_643_1.var_.characterEffect1085ui_story and not isNil(var_646_1) then
					arg_643_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= 0 + var_646_2 and arg_643_1.time_ < 0 + var_646_2 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect1085ui_story then
				arg_643_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_2")
			end

			local var_646_4 = 0
			local var_646_5 = 0.425

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_6 = arg_643_1:GetWordFromCfg(1108504156)
				local var_646_7 = arg_643_1:FormatText(var_646_6.content)

				arg_643_1.text_.text = var_646_7

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_9 = 17 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 17)

				if (17 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 17)) > 0 and var_646_5 < var_646_9 then
					arg_643_1.talkMaxDuration = var_646_9

					if var_646_9 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_9 + var_646_4
					end
				end

				arg_643_1.text_.text = var_646_7
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb") ~= 0 then
					local var_646_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb") / 1000

					if var_646_10 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_10 + var_646_4
					end

					if var_646_6.prefab_name ~= "" and arg_643_1.actors_[var_646_6.prefab_name] ~= nil then
						local var_646_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_6.prefab_name].transform, "story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb")

						arg_643_1:RecordAudio("1108504156", var_646_11)
						arg_643_1:RecordAudio("1108504156", var_646_11)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_12 = math.max(var_646_5, arg_643_1.talkMaxDuration)

			if var_646_4 <= arg_643_1.time_ and arg_643_1.time_ < var_646_4 + var_646_12 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_4) / var_646_12

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_4 + var_646_12 and arg_643_1.time_ < var_646_4 + var_646_12 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play1108504157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1108504157
		arg_647_1.duration_ = 3.6

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
			arg_647_1.auto_ = false
		end

		function arg_647_1.playNext_(arg_649_0)
			arg_647_1.onStoryFinished_()
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.var_.moveOldPos1085ui_story = arg_647_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_650_0 = 0.001

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_0 then
				arg_647_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_647_1.time_ - 0) / var_650_0)
				arg_647_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_647_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1085ui_story"].transform.position).z)
				arg_647_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_647_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_647_1.actors_["1085ui_story"].transform.localEulerAngles = arg_647_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_647_1.time_ >= 0 + var_650_0 and arg_647_1.time_ < 0 + var_650_0 + arg_650_0 then
				arg_647_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_647_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_647_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1085ui_story"].transform.position).z)
				arg_647_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_647_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_647_1.actors_["1085ui_story"].transform.localEulerAngles = arg_647_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_650_1 = 0
			local var_650_2 = 0.25

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_1 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_3 = arg_647_1:GetWordFromCfg(1108504157)
				local var_650_4 = arg_647_1:FormatText(var_650_3.content)

				arg_647_1.text_.text = var_650_4

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_6 = 10 <= 0 and var_650_2 or var_650_2 * (utf8.len(var_650_4) / 10)

				if (10 <= 0 and var_650_2 or var_650_2 * (utf8.len(var_650_4) / 10)) > 0 and var_650_2 < var_650_6 then
					arg_647_1.talkMaxDuration = var_650_6

					if var_650_6 + var_650_1 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_6 + var_650_1
					end
				end

				arg_647_1.text_.text = var_650_4
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb") ~= 0 then
					local var_650_7 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb") / 1000

					if var_650_7 + var_650_1 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_7 + var_650_1
					end

					if var_650_3.prefab_name ~= "" and arg_647_1.actors_[var_650_3.prefab_name] ~= nil then
						local var_650_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_3.prefab_name].transform, "story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb")

						arg_647_1:RecordAudio("1108504157", var_650_8)
						arg_647_1:RecordAudio("1108504157", var_650_8)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_9 = math.max(var_650_2, arg_647_1.talkMaxDuration)

			if var_650_1 <= arg_647_1.time_ and arg_647_1.time_ < var_650_1 + var_650_9 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_1) / var_650_9

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_1 + var_650_9 and arg_647_1.time_ < var_650_1 + var_650_9 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play1108504138 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1108504138
		arg_651_1.duration_ = 2.8

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1108504139(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0.2

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_1 = arg_651_1:GetWordFromCfg(1108504138)
				local var_654_2 = arg_651_1:FormatText(var_654_1.content)

				arg_651_1.text_.text = var_654_2

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_4 = 8 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 8)

				if (8 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 8)) > 0 and var_654_0 < var_654_4 then
					arg_651_1.talkMaxDuration = var_654_4

					if var_654_4 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_4 + 0
					end
				end

				arg_651_1.text_.text = var_654_2
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb") ~= 0 then
					local var_654_5 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb") / 1000

					if var_654_5 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + 0
					end

					if var_654_1.prefab_name ~= "" and arg_651_1.actors_[var_654_1.prefab_name] ~= nil then
						local var_654_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_1.prefab_name].transform, "story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb")

						arg_651_1:RecordAudio("1108504138", var_654_6)
						arg_651_1:RecordAudio("1108504138", var_654_6)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_7 = math.max(var_654_0, arg_651_1.talkMaxDuration)

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_7 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - 0) / var_654_7

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= 0 + var_654_7 and arg_651_1.time_ < 0 + var_654_7 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play1108504139 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1108504139
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1108504140(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0.2

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_1 = arg_655_1:FormatText(arg_655_1:GetWordFromCfg(1108504139).content)

				arg_655_1.text_.text = var_658_1

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_3 = 8 <= 0 and var_658_0 or var_658_0 * (utf8.len(var_658_1) / 8)

				if (8 <= 0 and var_658_0 or var_658_0 * (utf8.len(var_658_1) / 8)) > 0 and var_658_0 < var_658_3 then
					arg_655_1.talkMaxDuration = var_658_3

					if var_658_3 + 0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_3 + 0
					end
				end

				arg_655_1.text_.text = var_658_1
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_4 = math.max(var_658_0, arg_655_1.talkMaxDuration)

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_4 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - 0) / var_658_4

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= 0 + var_658_4 and arg_655_1.time_ < 0 + var_658_4 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1108504046 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1108504046
		arg_659_1.duration_ = 7.67

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1108504047(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1.var_.moveOldPos1085ui_story = arg_659_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_662_0 = 0.001

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_0 then
				arg_659_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_659_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_659_1.time_ - 0) / var_662_0)
				arg_659_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_659_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1085ui_story"].transform.position).z)
				arg_659_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_659_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_659_1.actors_["1085ui_story"].transform.localEulerAngles = arg_659_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_659_1.time_ >= 0 + var_662_0 and arg_659_1.time_ < 0 + var_662_0 + arg_662_0 then
				arg_659_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_659_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_659_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_659_1.actors_["1085ui_story"].transform.position).z)
				arg_659_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_659_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_659_1.actors_["1085ui_story"].transform.localEulerAngles = arg_659_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_662_1 = arg_659_1.actors_["1085ui_story"]

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(var_662_1) and arg_659_1.var_.characterEffect1085ui_story == nil then
				arg_659_1.var_.characterEffect1085ui_story = var_662_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_2 = 0.200000002980232

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_2 and not isNil(var_662_1) then
				if arg_659_1.var_.characterEffect1085ui_story and not isNil(var_662_1) then
					arg_659_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_659_1.time_ >= 0 + var_662_2 and arg_659_1.time_ < 0 + var_662_2 + arg_662_0 and not isNil(var_662_1) and arg_659_1.var_.characterEffect1085ui_story then
				arg_659_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_662_4 = "1085ui_story"

			if arg_659_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_662_5 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_659_1.stage_.transform)

				var_662_5.name = var_662_4
				var_662_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_659_1.actors_[var_662_4] = var_662_5

				local var_662_6 = var_662_5:GetComponentInChildren(typeof(CharacterEffect))

				var_662_6.enabled = true

				local var_662_7 = GameObjectTools.GetOrAddComponent(var_662_5, typeof(DynamicBoneHelper))

				if var_662_7 then
					var_662_7:EnableDynamicBone(false)
				end

				arg_659_1:ShowWeapon(var_662_6.transform, false)

				arg_659_1.var_[var_662_4 .. "Animator"] = var_662_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_659_1.var_[var_662_4 .. "Animator"].applyRootMotion = true
				arg_659_1.var_[var_662_4 .. "LipSync"] = var_662_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_662_8 = "1085ui_story"

			if arg_659_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_662_9 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_659_1.stage_.transform)

				var_662_9.name = var_662_8
				var_662_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_659_1.actors_[var_662_8] = var_662_9

				local var_662_10 = var_662_9:GetComponentInChildren(typeof(CharacterEffect))

				var_662_10.enabled = true

				local var_662_11 = GameObjectTools.GetOrAddComponent(var_662_9, typeof(DynamicBoneHelper))

				if var_662_11 then
					var_662_11:EnableDynamicBone(false)
				end

				arg_659_1:ShowWeapon(var_662_10.transform, false)

				arg_659_1.var_[var_662_8 .. "Animator"] = var_662_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_659_1.var_[var_662_8 .. "Animator"].applyRootMotion = true
				arg_659_1.var_[var_662_8 .. "LipSync"] = var_662_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_662_12 = 0
			local var_662_13 = 0.65

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_12 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_14 = arg_659_1:GetWordFromCfg(1108504046)
				local var_662_15 = arg_659_1:FormatText(var_662_14.content)

				arg_659_1.text_.text = var_662_15

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_17 = 26 <= 0 and var_662_13 or var_662_13 * (utf8.len(var_662_15) / 26)

				if (26 <= 0 and var_662_13 or var_662_13 * (utf8.len(var_662_15) / 26)) > 0 and var_662_13 < var_662_17 then
					arg_659_1.talkMaxDuration = var_662_17

					if var_662_17 + var_662_12 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_17 + var_662_12
					end
				end

				arg_659_1.text_.text = var_662_15
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb") ~= 0 then
					local var_662_18 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb") / 1000

					if var_662_18 + var_662_12 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_18 + var_662_12
					end

					if var_662_14.prefab_name ~= "" and arg_659_1.actors_[var_662_14.prefab_name] ~= nil then
						local var_662_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_14.prefab_name].transform, "story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb")

						arg_659_1:RecordAudio("1108504046", var_662_19)
						arg_659_1:RecordAudio("1108504046", var_662_19)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_20 = math.max(var_662_13, arg_659_1.talkMaxDuration)

			if var_662_12 <= arg_659_1.time_ and arg_659_1.time_ < var_662_12 + var_662_20 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_12) / var_662_20

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_12 + var_662_20 and arg_659_1.time_ < var_662_12 + var_662_20 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_659_1:InitPlayNodeList()
	end,
	Play1108504047 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1108504047
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1108504048(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(arg_663_1.actors_["1085ui_story"]) and arg_663_1.var_.characterEffect1085ui_story == nil then
				arg_663_1.var_.characterEffect1085ui_story = arg_663_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_0 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 and not isNil(arg_663_1.actors_["1085ui_story"]) then
				if arg_663_1.var_.characterEffect1085ui_story and not isNil(arg_663_1.actors_["1085ui_story"]) then
					arg_663_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_663_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_663_1.time_ - 0) / var_666_0)
				end
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 and not isNil(arg_663_1.actors_["1085ui_story"]) and arg_663_1.var_.characterEffect1085ui_story then
				arg_663_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_663_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_666_1 = 0
			local var_666_2 = 0.65

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_663_1.callingController_:SetSelectedState("normal")

				arg_663_1.keyicon_.color = Color.New(1, 1, 1)
				arg_663_1.icon_.color = Color.New(1, 1, 1)

				local var_666_3 = arg_663_1:FormatText(arg_663_1:GetWordFromCfg(1108504047).content)

				arg_663_1.text_.text = var_666_3

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_5 = 27 <= 0 and var_666_2 or var_666_2 * (utf8.len(var_666_3) / 27)

				if (27 <= 0 and var_666_2 or var_666_2 * (utf8.len(var_666_3) / 27)) > 0 and var_666_2 < var_666_5 then
					arg_663_1.talkMaxDuration = var_666_5

					if var_666_5 + var_666_1 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_5 + var_666_1
					end
				end

				arg_663_1.text_.text = var_666_3
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_6 = math.max(var_666_2, arg_663_1.talkMaxDuration)

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_6 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_1) / var_666_6

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_1 + var_666_6 and arg_663_1.time_ < var_666_1 + var_666_6 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST20",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/ST12a",
		"TextureConfig/Background/R8501",
		"TextureConfig/Background/R8501a"
	},
	voices = {
		"story_v_side_new_1108504.awb"
	}
}
